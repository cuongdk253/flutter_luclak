import 'package:appchat/pages/authentication/step_create_user/step_create_user_view.dart';
import 'package:appchat/services/constant.dart';
import 'package:appchat/services/others/local_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../services/http/getx_http.dart';
import '../../services/socket/socket.dart';
import '../authentication/login/login_view.dart';
import '../tab/tab_view.dart';

class SplashController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();

  @override
  void onReady() async {
    super.onReady();

    _autoLogin();
  }

  _autoLogin() async {
    var _phone = await SPreferentModule().getItem(StorageKey.phoneNumber);
    String _fcmToken = (await FirebaseMessaging.instance.getToken())!;
    if (_phone != null) {
      Map _body = {
        "username": _phone.replaceAll('+', ''),
        "fcm_token": _fcmToken,
      };
      var _res = await _httpProvider.doAutoLogin(_body);
      if (_res != null) {
        _httpProvider.setToken(_res['accessToken']);
        Get.put(MySocketController(_phone));
        if (_res['user_validate'] == true) {
          return Get.to(() => MyTabView());
        } else {
          return Get.to(() => StepCreateUserView());
        }
      }
    }
    Get.to(() => LoginView());
  }
}
