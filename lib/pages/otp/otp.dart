import 'package:appchat/pages/login/login.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/constant.dart';
import '../../services/others/local_storage.dart';

class OtpController extends GetxController {
  final LoginController _loginController = Get.find();

  TextEditingController otp = TextEditingController();

  // @override
  // onInit() async {
  //   super.onInit();
  // }

  onClickBack() {
    Get.back();
  }

  onClickVerification() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _loginController.verificationId!, smsCode: otp.text);

    String _phone =
        _loginController.phoneCode.value + _loginController.phone.text;

    final authCredential = await _loginController.firebaseAuth
        .signInWithCredential(phoneAuthCredential);

    if (authCredential.user != null) {
      Map _body = {"phone": _phone, "fcm_token": _loginController.fcmToken};

      var _res = await _loginController.httpProvider.doVerifyUser(_body);
      if (_res != null) {
        SPreferentModule().setItem(StorageKey.phoneNumber, _phone);
        _loginController.doLogin(_res['accessToken']);
      }
    } else {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'verify_otp'.tr,
        autoHide: const Duration(seconds: 2),
        desc: 'verify_otp_fail'.tr,
      ).show();
    }
  }
}
