import 'dart:io';

import 'package:appchat/pages/authentication/login/login_view.dart';
import 'package:appchat/pages/authentication/step_create_profile/step_create_profile_view.dart';
import 'package:appchat/pages/authentication/step_create_user/step_create_user_view.dart';
import 'package:appchat/pages/tab/tab_view.dart';
import 'package:appchat/services/constant.dart';
import 'package:appchat/services/others/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'services/http/getx_http.dart';
import 'services/language/language.dart';
import 'services/socket/socket.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

String mode = 'product';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('assets/ca/luclak_com.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  HttpOverrides.global = MyHttpOverrides();

  initLocalNotification();
  await initFirebase();

  Widget _firstScreen = await initBackEndService();

  await Future.delayed(const Duration(seconds: 5));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) {
      runApp(MyApp(_firstScreen));
    },
  );
}

initLocalNotification() async {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('logo');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int? id, String? title, String? body, String? payload) async {});
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
}

/// Khởi tạo firebase message
Future initFirebase() async {
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
  //   if (message != null) {
  //     handleNotificationTap(message.data);
  //   }
  // });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'fcm_notif',
      'fcm_notif',
      icon: 'mipmap/launcher_icon',
      largeIcon: DrawableResourceAndroidBitmap('mipmap/launcher_icon'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
      );
    }
  });

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   handleNotificationTap(message.data);
  // });
}

/// Khởi tạo api, socket
Future<Widget> initBackEndService() async {
  Get.lazyPut(() => MyHttpProvider());
  Get.lazyPut(() => MySocketController());

  final MyHttpProvider _httpProvider = Get.find();
  final MySocketController _socket = Get.find();

  var _phone = await SPreferentModule().getItem(StorageKey.phoneNumber);
  String _fcmToken = (await FirebaseMessaging.instance.getToken())!;
  Map _body = {
    "username": _phone != null ? _phone.replaceAll('+', '') : '',
    "fcm_token": _fcmToken,
  };
  var _res = await _httpProvider.doAutoLogin(_body);

  if (_res != null) {
    mode = _res['mode'];

    if (_res['accessToken'] != null) {
      _httpProvider.setToken(_res['accessToken']);
      _socket.initSocket(_phone);

      if (_res['user_validate'] == true && _res['provider_avaiable'] == true) {
        return MyTabView();
      } else if (_res['user_validate'] == true &&
          _res['provider_avaiable'] == false) {
        return StepCreateProfileView();
      } else if (_res['user_validate'] == false &&
          _res['provider_avaiable'] == false) {
        return StepCreateUserView();
      }
    }
  }
  return LoginView();
}

class MyApp extends StatelessWidget {
  const MyApp(this.firstScreen, {Key? key}) : super(key: key);

  final Widget firstScreen;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'Nunito'),
      debugShowCheckedModeBanner: false,
      translations: LocalizationService(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('vi'), Locale('en')],
      home: firstScreen,
    );
  }
}
