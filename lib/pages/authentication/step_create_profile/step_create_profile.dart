import 'package:appchat/components/format_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/text.dart';
import '../../../services/constant.dart';
import '../../../services/http/getx_http.dart';
import '../../../services/http/post_multipart.dart';
import '../../../services/themes/app_theme.dart';
import '../done_create_profile/done_create_profile_view.dart';

class StepCreateProfileController extends GetxController
    with GetTickerProviderStateMixin {
  final MyHttpProvider _httpProvider = Get.find();
  final ImagePicker _imagePicker = ImagePicker();

  TextEditingController aboutYou = TextEditingController();

  RxDouble processStep = 0.25.obs;

  final double maxPubget = 10000.0;
  final double itemValuePubget = 100.0;
  RxDouble pubgetStart = 0.0.obs;
  RxDouble pubgetEnd = 100.0.obs;

  FixedExtentScrollController? pubgetStartController;
  FixedExtentScrollController? pubgetEndController;

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

  List listPower = ListConstant().listPower;

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
      if (step.value < 4) {
        if (step.value < 3) {
          canNext.value = false;
        }

        _controller.forward();

        await Future.delayed(const Duration(milliseconds: 300));
        step.value += 1;
        processStep.value += 0.25;

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

    if (pickedFile != null) {
      listImage[index]['uploading'].value = true;

      var _res = await HttpPostMultipart().doUploadImage(
          path: pickedFile.path,
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
      "powers": _listPower,
      "money_from": pubgetStart.value,
      "money_to": pubgetEnd.value,
    };

    var _res = await _httpProvider.doCreateProfile(_body);
    if (_res != null) {
      Get.to(() => DoneCreateProfileView());
    }
  }

  onPubgetChange(RangeValues value) {
    pubgetStart.value = value.start;
    pubgetEnd.value = value.end;
  }

  onClickPubget() async {
    pubgetStartController = FixedExtentScrollController(
        initialItem: pubgetStart.value != 0
            ? (pubgetStart.value / itemValuePubget).round()
            : 0);
    pubgetEndController = FixedExtentScrollController(
        initialItem: pubgetEnd.value != 0
            ? (pubgetEnd.value / itemValuePubget).round()
            : 0);

    await Get.bottomSheet(
      SizedBox(
        height: 250,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1, color: AppTheme.colorDisable),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: TextCustom(
                          'your_pubget'.tr,
                          style: AppTheme.textStyle16.medium().textDark(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextCustom(
                              'done'.tr,
                              style: AppTheme.textStyle16.medium().secondary(),
                            ),
                          ),
                          onTap: () => Get.back(),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 4),
                            TextCustom(
                              'min_pubget'.tr,
                              style: AppTheme.textStyle.textDark(),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 36,
                                scrollController: pubgetStartController,
                                onSelectedItemChanged: (int index) {
                                  pubgetStart.value = index * itemValuePubget;
                                  if (pubgetEnd.value <= pubgetStart.value) {
                                    pubgetEndController!.animateToItem(
                                      index + 1,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                children: List.generate(
                                  (maxPubget / itemValuePubget).round(),
                                  (int index) => Center(
                                    child: TextCustom(
                                      formatNumberString(
                                          index * itemValuePubget),
                                      style: AppTheme.textStyle16.textDark(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(height: 4),
                            TextCustom(
                              'max_pubget'.tr,
                              style: AppTheme.textStyle.textDark(),
                            ),
                            Expanded(
                              child: CupertinoPicker(
                                itemExtent: 36,
                                scrollController: pubgetEndController,
                                onSelectedItemChanged: (int index) {
                                  pubgetEnd.value = index * itemValuePubget;
                                  if (pubgetEnd.value <= pubgetStart.value) {
                                    pubgetEndController!.animateToItem(
                                      index + 1,
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                children: List.generate(
                                  (maxPubget / itemValuePubget).round(),
                                  (int index) => Center(
                                    child: TextCustom(
                                      formatNumberString(
                                          index * itemValuePubget),
                                      style: AppTheme.textStyle16.textDark(),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
