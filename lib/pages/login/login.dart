import 'package:appchat/pages/tab/tab_view.dart';
import 'package:appchat/services/socket/socket.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/http/getx_http.dart';
// import '../otp/otp_view.dart';
// import '../otp/otp_view.dart';
// import '../tab/tab_view.dart';

class LoginController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();

  TextEditingController phone = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String? verificationId;

  // @override
  // onInit() async {
  //   super.onInit();
  // }

  onClickNext() async {
    _httpProvider.setToken(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7Il9pZCI6ImZjbV90b2tlbiIsInVzZXJJRCI6IjAzOTg0OTg5NjAifSwiaWF0IjoxNjU0ODI3MzA4LCJleHAiOjE2ODYzNjMzMDh9.DmqiN5_sci1PmrzV3N3pyeAewK5jF6TDsySsW3mIZH0");
    Get.put(MySocketController('0398498960'));
    Get.to(() => MyTabView());

    // String? token = await FirebaseMessaging.instance.getToken();

    // debugPrint(token);

    // PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
    //     verificationId: _verificationId!, smsCode: pinCode!);

    // final authCredential =
    //     await _auth.signInWithCredential('phoneAuthCredential');

    // await firebaseAuth.verifyPhoneNumber(
    //   phoneNumber: '+84${phone.text}',
    //   timeout: const Duration(seconds: 120),
    //   verificationCompleted: (phoneAuthCredential) async {
    //     // print(phoneAuthCredential);
    //   },
    //   verificationFailed: (verificationFailed) async {
    //     debugPrint(verificationFailed.toString());
    //     debugPrint(
    //         'Gửi mã xác thực thất bại, vui lòng kiểm tra lại số điện thoại của bạn!');
    //   },
    //   codeSent: (_verificationId, resendingToken) async {
    //     debugPrint(resendingToken.toString());
    //     debugPrint(verificationId.toString());
    //     verificationId = _verificationId;

        // Get.to(() => OtpView());

    //     // timeLoad();
    //   },
    //   codeAutoRetrievalTimeout: (verificationId) async {
    //     debugPrint(verificationId);
    //   },
    // );
  }
}
