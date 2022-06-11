import 'package:appchat/pages/tab/tab_view.dart';
import 'package:appchat/services/socket/socket.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/http/getx_http.dart';
// import '../otp/otp_view.dart';
// import '../tab/tab_view.dart';

class LoginController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();

  TextEditingController phone = TextEditingController();

  // @override
  // onInit() async {
  //   super.onInit();
  // }

  onClickNext() {
    _httpProvider.setToken(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7Il9pZCI6ImZjbV90b2tlbiIsInVzZXJJRCI6IjAzOTg0OTg5NjAifSwiaWF0IjoxNjU0ODI3MzA4LCJleHAiOjE2ODYzNjMzMDh9.DmqiN5_sci1PmrzV3N3pyeAewK5jF6TDsySsW3mIZH0");
    Get.put(MySocketController('0398498960'));
    Get.to(() => MyTabView());

    // Get.to(() => OtpView());
  }
}
