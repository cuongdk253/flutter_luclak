import 'package:appchat/components/text.dart';
import 'package:appchat/pages/authentication/done_create_profile/done_create_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../services/http/getx_http.dart';
import '../../../services/http/post_multipart.dart';
import '../../../services/themes/app_theme.dart';

class StepCreateProfileController extends GetxController
    with GetTickerProviderStateMixin {
  final MyHttpProvider _httpProvider = Get.find();
  final ImagePicker _imagePicker = ImagePicker();

  TextEditingController aboutYou = TextEditingController();

  RxDouble processStep = 0.34.obs;

  List listImage = [
    {
      'image_url': '',
      'uploading': false.obs,
      'process': 0.0.obs,
    },
    {
      'image_url': '',
      'uploading': false.obs,
      'process': 0.0.obs,
    },
  ].obs;

  List listUrlImage = [];

  List listPower = [
    {'name': 'Photograp', 'checked': false},
    {'name': 'Edit video', 'checked': false},
    {'name': 'Review SP', 'checked': false},
    {'name': 'Crafts', 'checked': false},
    {'name': 'Singing', 'checked': false},
    {'name': 'Art', 'checked': false},
    {'name': 'Writing', 'checked': false},
    {'name': 'Stream', 'checked': false},
    {'name': 'Design', 'checked': false},
    {'name': 'DJ', 'checked': false},
  ];

  RxString power = ''.obs;

  RxBool canNext = false.obs;

  int idUpdateImage = 2;

  RxInt step = 1.obs;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  onClickNext() async {
    if (canNext.value) {
      if (step.value < 3) {
        canNext.value = false;

        _controller.forward();

        await Future.delayed(const Duration(milliseconds: 300));
        step.value += 1;
        processStep.value += 0.33;

        _controller.reset();
      } else {
        doUpdateProfileAndNext();
      }
    }
  }

  onClickImage(int index) {
    if (listImage[index]['image_url'] != '') {
      Get.bottomSheet(
        SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: Container(
                  height: 48,
                  width: Get.width,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppTheme.gradient),
                  child: TextCustom(
                    'delete_image'.tr,
                    style: AppTheme.textStyle16.medium().white(),
                  ),
                ),
                onTap: () async {
                  Get.back();

                  listImage[index]['image_url'] = '';
                  canNext.value = false;
                  update([idUpdateImage]);
                },
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
      );
    } else {
      Get.bottomSheet(
        SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                child: Container(
                  height: 48,
                  width: Get.width,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppTheme.gradient),
                  child: TextCustom(
                    'library_image'.tr,
                    style: AppTheme.textStyle16.medium().white(),
                  ),
                ),
                onTap: () async {
                  Get.back();
                  uploadImage(ImageSource.gallery, index);
                },
              ),
              InkWell(
                child: Container(
                  height: 48,
                  width: Get.width,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: AppTheme.gradient),
                  child: TextCustom(
                    'take_photo'.tr,
                    style: AppTheme.textStyle16.medium().white(),
                  ),
                ),
                onTap: () async {
                  Get.back();
                  uploadImage(ImageSource.camera, index);
                },
              ),
              const SizedBox(height: 16)
            ],
          ),
        ),
      );
    }
  }

  uploadImage(ImageSource source, int index) async {
    final pickedFile = await _imagePicker.pickImage(source: source);

    listImage[index]['uploading'].value = true;

    var _res = await HttpPostMultipart().doUploadImage(
        path: pickedFile!.path,
        onUploadProgress: (value) {
          listImage[index]['process'].value = value;
        });

    listImage[index]['uploading'].value = false;

    if (_res != null) {
      listImage[index]['image_url'] = _res['path'];
    }

    update([idUpdateImage]);

    listUrlImage = [];

    for (var i in listImage) {
      if (i['image_url'] != '') {
        listUrlImage.add(i['image_url']);
      }
    }

    if (listUrlImage.length > 1) {
      canNext.value = true;
    }
  }

  onClickPower(int index) {
    listPower[index]['checked'] = !listPower[index]['checked'];

    int _powerCount = 0;

    for (var i in listPower) {
      if (i['checked'] == true) {
        _powerCount++;
      }
    }
    if (_powerCount > 2) {
      canNext.value = true;
    } else {
      canNext.value = false;
    }
    update();
  }

  onChangeAbout() {
    if (aboutYou.text != '') {
      canNext.value = true;
    }
  }

  doUpdateProfileAndNext() async {
    List<String> _listPower = [];
    for (var i in listPower) {
      if (i['checked'] == true) {
        _listPower.add(i['name']);
      }
    }
    Map _body = {
      "about": aboutYou.text,
      "images": listUrlImage,
      "powers": _listPower
    };

    debugPrint(_body.toString());

    var _res = await _httpProvider.doCreateProfile(_body);
    if (_res != null) {
      Get.to(() => DoneCreateProfileView());
    }
  }
}
