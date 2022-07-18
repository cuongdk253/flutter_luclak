import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'pages/splash/splash_view.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data = await PlatformAssetBundle().load('assets/ca/luclak_com.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  HttpOverrides.global = MyHttpOverrides();

  // initLocalNotification();
  await initFirebase();

  Get.lazyPut(() => MyHttpProvider());
  Get.lazyPut(() => MySocketController());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) {
      runApp(const MyApp());
    },
  );
}

// initLocalNotification() async {
//   var initializationSettingsAndroid =
//       const AndroidInitializationSettings('logo');
//   var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       onDidReceiveLocalNotification:
//           (int? id, String? title, String? body, String? payload) async {});
//   var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onSelectNotification: (String? payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: ' + payload);
//     }
//   });
// }

/// Khởi tạo firebase message
Future initFirebase() async {
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      // handleNotificationTap(message.data);
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;

    // // ignore: prefer_const_constructors
    // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   'fcm_notif',
    //   'fcm_notif',
    //   icon: 'mipmap/launcher_icon',
    //   largeIcon: const DrawableResourceAndroidBitmap('mipmap/launcher_icon'),
    // );

    // var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
    //     presentAlert: true, presentBadge: true, presentSound: true);
    // var platformChannelSpecifics = NotificationDetails(
    //     android: androidPlatformChannelSpecifics,
    //     iOS: iOSPlatformChannelSpecifics);

    // if (notification != null && android != null) {
    //   flutterLocalNotificationsPlugin.show(
    //     notification.hashCode,
    //     notification.title,
    //     notification.body,
    //     platformChannelSpecifics,
    //   );
    // }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // handleNotificationTap(message.data);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: SplashView(),
    );
  }
}
