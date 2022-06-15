import 'package:appchat/components/text.dart';
import 'package:appchat/services/http/post_multipart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/http/getx_http.dart';
import '../../services/themes/app_theme.dart';

class DetailProfileController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  // final MySocketController _socket = Get.find();

  String? profileID;

  final ImagePicker _imagePicker = ImagePicker();

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
  ].obs;

  @override
  onInit() async {
    super.onInit();

    loadDetail();
  }

  loadDetail() async {
    profileID = Get.arguments;
    if (!profileID!.contains('_')) {
      profileID =
          profileID! + '_' + DateTime.now().millisecondsSinceEpoch.toString();
    } else {
      Map _body = {'profile_id': profileID};
      var _res = await _httpProvider.getDetailProfile(_body);
      if (_res != null) {
        if (_res['images'] != null) {
          for (int i = 0; i < _res['images'].length; i++) {
            listImage[i]['image_url'] = _res['images'][i];
          }
          update();
        }
      }
    }
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

                  listImage[index] = '';
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

    var _listImage = [];

    for (var i in listImage) {
      if (i['image_url'] != '') {
        _listImage.add(i['image_url']);
      }
    }

    Map _body = {
      'profile_id': profileID,
      'images': _listImage,
    };

    _httpProvider.doUpdateProfile(_body);
  }
}
