import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../services/http/getx_http.dart';
import '../../../services/socket/socket.dart';
import '../../tab/tab_view.dart';
import '../fill_phone/fill_phone_view.dart';
import '../step_create_user/step_create_user_view.dart';

class LoginController extends GetxController {
  final MyHttpProvider httpProvider = Get.find();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String? verificationId;

  String username = '';
  String fcmToken = '';

  @override
  onInit() async {
    super.onInit();

    loadData();
  }

  loadData() async {
    fcmToken = (await FirebaseMessaging.instance.getToken())!;
  }

  doLogin(res) {
    httpProvider.setToken(res['access_token']);
    Get.put(MySocketController(username));

    if (res['user_exits'] == true) {
      Get.to(() => MyTabView());
    } else {
      Get.to(() => StepCreateUserView());
    }
  }

  onClickLoginByPhone() async {
    Get.to(() => FillPhoneView());
  }
}
