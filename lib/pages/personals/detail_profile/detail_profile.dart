import 'package:appchat/components/text.dart';
import 'package:appchat/pages/personals/personal/personal.dart';
import 'package:appchat/services/constant.dart';
import 'package:appchat/services/http/getx_http.dart';
import 'package:appchat/services/http/post_multipart.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DetailProfileController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  final PersonalController personalController = Get.find();

  final ImagePicker _imagePicker = ImagePicker();

  TextEditingController aboutYou = TextEditingController();

  RxString power = ''.obs;

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
    {
      'image_url': '',
      'uploading': false.obs,
      'process': 0.0.obs,
    },
  ].obs;

  List listPower = ListConstant().listPower;

  @override
  onInit() async {
    super.onInit();

    loadDetail();
  }

  loadDetail() async {
    for (int i = 0; i < personalController.user.listImage.length; i++) {
      listImage[i]['image_url'] = personalController.user.listImage[i];
    }

    String _power = '';
    for (String i in personalController.user.listPower) {
      _power = _power + ', ' + i;
    }
    _power = _power.substring(2);
    power.value = _power;
    for (var i in listPower) {
      if (power.value.contains(i['name'])) {
        i['checked'] = true;
      } else {
        i['checked'] = false;
      }
    }

    aboutYou.text = personalController.user.about;

    update();
  }

  onClickBack() {
    Get.back();
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
                  List _newList = [];
                  for (var i in listImage) {
                    if (i['image_url'] != '') {
                      _newList.add(i);
                    }
                  }
                  for (var i in listImage) {
                    if (i['image_url'] == '') {
                      _newList.add(i);
                    }
                  }
                  listImage = _newList;

                  update();
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

    update();
  }

  onClickPowerCard() async {
    await Get.bottomSheet(
      SafeArea(
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(Get.context!).padding.top + 16),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Container(
              color: AppTheme.colorBackgroundCard,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(border: AppTheme.borderBottomLine),
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          InkWell(
                            child: SvgPicture.asset(
                              'assets/svgs/close.svg',
                              color: AppTheme.colorWhite,
                            ),
                            onTap: () => Get.back(),
                          ),
                          Expanded(
                            child: TextCustom(
                              'power'.tr,
                              style: AppTheme.textStyle20.bold(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(width: 24)
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: GetBuilder<DetailProfileController>(
                          builder: (_) => Wrap(
                              children: List.generate(
                            listPower.length,
                            (index) => InkWell(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 16, right: 16),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppTheme.colorWhite.withOpacity(
                                      listPower[index]['checked'] == true
                                          ? 1.0
                                          : 0.5),
                                ),
                                child: TextCustom(
                                  listPower[index]['name'],
                                  style:
                                      AppTheme.textStyle16.medium().textDark(),
                                ),
                              ),
                              onTap: () => onClickPower(index),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    updatePower();
  }

  onClickPower(int index) {
    listPower[index]['checked'] = !listPower[index]['checked'];
    update();
  }

  updatePower() {
    String _power = '';
    for (var i in listPower) {
      if (i['checked'] == true) {
        _power = _power + ', ' + i['name'];
      }
    }
    _power = _power.substring(2);
    power.value = _power;
  }

  onClickDone() async {
    var _listImage = [];

    for (var i in listImage) {
      if (i['image_url'] != '') {
        _listImage.add(i['image_url']);
      }
    }

    var _listPower = power.value.split(', ');

    Map _body = {
      'profile_id': personalController.user.profileID,
      'powers': _listPower,
      'images': _listImage,
      'about': aboutYou.text,
    };

    var _res = await _httpProvider.doUpdateProfile(_body);
    if (_res != null) {
      personalController.user.listImage = _listImage;
      personalController.user.listPower = _listPower;
      personalController.user.about = aboutYou.text;

      Get.back();
    }
  }
}
