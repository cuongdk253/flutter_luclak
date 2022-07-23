// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';

// import '../../services/constant.dart';
// import '../../services/http/getx_http.dart';
// import '../../services/others/local_storage.dart';
// import '../../services/socket/socket.dart';
// import '../authentication/login/login_view.dart';
// import '../authentication/step_create_profile/step_create_profile_view.dart';
// import '../authentication/step_create_user/step_create_user_view.dart';
// import '../tab/tab_view.dart';

// class SplashController extends GetxController {
//   final MyHttpProvider _httpProvider = Get.find();
//   final MySocketController _socket = Get.find();

//   String mode = 'product';

//   @override
//   void onReady() async {
//     super.onReady();

//     _autoLogin();
//   }

//   _autoLogin() async {
//     var _phone = await SPreferentModule().getItem(StorageKey.phoneNumber);
//     String _fcmToken = (await FirebaseMessaging.instance.getToken())!;
//     Map _body = {
//       "username": _phone != null ? _phone.replaceAll('+', '') : '',
//       "fcm_token": _fcmToken,
//     };
//     var _res = await _httpProvider.doAutoLogin(_body);
//     if (_res != null) {
//       mode = _res['mode'];

//       if (_res['accessToken'] != null) {
//         _httpProvider.setToken(_res['accessToken']);
//         _socket.initSocket(_phone);

//         if (_res['user_validate'] == true &&
//             _res['provider_avaiable'] == true) {
//           return Get.to(() => MyTabView());
//         } else if (_res['user_validate'] == true &&
//             _res['provider_avaiable'] == false) {
//           return Get.to(() => StepCreateProfileView());
//         } else if (_res['user_validate'] == false &&
//             _res['provider_avaiable'] == false) {
//           return Get.to(() => StepCreateUserView());
//         }
//       }
//     }
//     Get.to(() => LoginView());
//   }
// }
