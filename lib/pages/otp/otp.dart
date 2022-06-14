import 'package:appchat/pages/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
    debugPrint(otp.text);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _loginController.verificationId!, smsCode: otp.text);

    final authCredential = await _loginController.firebaseAuth
        .signInWithCredential(phoneAuthCredential);

    if (authCredential.user != null) {
      debugPrint(authCredential.user.toString());
    }
  }
}
