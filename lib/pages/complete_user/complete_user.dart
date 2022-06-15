import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../services/constant.dart';
import '../../services/others/local_storage.dart';
import '../login/login.dart';

class CompleteUserController extends GetxController {
  final LoginController _loginController = Get.find();

  TextEditingController name = TextEditingController();

  RxString birth = 'dd/mm/yyyy'.obs;
  RxString userType = 'kol'.obs;

  DateTime? birthDate;

  onClickBack() {
    Get.back();
  }

  onClickNext() async {
    if (name.text.isNotEmpty && birth.value != 'dd/mm/yyyy') {
      Map _body = {
        "username": _loginController.username,
        "name": name.text,
        "birth": birth.value,
        "type": userType.value,
        "fcm_token": _loginController.fcmToken,
      };
      var _res = await _loginController.httpProvider.doCreateUser(_body);

      if (_res != null) {
        SPreferentModule()
            .setItem(StorageKey.phoneNumber, _loginController.username);
        _loginController.doLogin(_res['accessToken']);
      }
    } else {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'fill_less'.tr,
        autoHide: const Duration(seconds: 2),
      ).show();
    }
  }

  onClickChangeBirth() async {
    birthDate = await showDatePicker(
      context: Get.context!,
      initialDate: birthDate ?? DateTime.now(),
      firstDate: DateFormat('dd/MM/yyyy').parse('01/01/1900'),
      lastDate: DateTime.now(),
    );
    if (birthDate != null) {
      birth.value = DateFormat('dd/MM/yyyy').format(birthDate!);
    }
  }
}
