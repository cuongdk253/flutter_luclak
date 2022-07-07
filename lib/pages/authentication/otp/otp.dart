import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../services/constant.dart';
import '../../../services/others/local_storage.dart';
import '../login/login.dart';

class OtpController extends GetxController {
  final LoginController _loginController = Get.find();

  TextEditingController otp = TextEditingController();

  onClickBack() {
    Get.back();
  }

  onClickVerification() async {
    try {
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: _loginController.verificationId!, smsCode: otp.text);

      var authCredential = await _loginController.firebaseAuth
          .signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        Map _body = {
          "username": _loginController.username.replaceAll('+', ''),
          "fcm_token": _loginController.fcmToken
        };

        var _res = await _loginController.httpProvider.doVerifyUser(_body);
        if (_res != null) {
          SPreferentModule()
              .setItem(StorageKey.phoneNumber, _loginController.username);
          _loginController.doLogin(_res);
        }
      } else {
        throw Exception('verify_otp_fail'.tr);
      }
    } catch (error) {
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
