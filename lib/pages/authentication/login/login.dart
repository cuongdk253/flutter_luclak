import 'package:appchat/components/loading.dart';
import 'package:appchat/pages/authentication/step_create_profile/step_create_profile_view.dart';
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
  final MySocketController _socket = Get.find();

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

    _socket.initSocket(username);

    if (res['user_validate'] == true && res['provider_avaiable'] == true) {
      Get.to(() => MyTabView());
    } else if (res['user_validate'] == true &&
        res['provider_avaiable'] == false) {
      Get.to(() => StepCreateProfileView());
    } else {
      Get.to(() => StepCreateUserView());
    }
  }

  onClickLoginByPhone() async {
    Get.to(() => FillPhoneView());
  }

  onClickLoginByGoogle() async {
    MyLoad().showLoading(context: Get.context!);

    await Future.delayed(const Duration(seconds: 5));
    MyLoad().hideLoading();
  }
}
