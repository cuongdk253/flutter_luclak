import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'components/loading/loading_controller.dart';
import 'pages/splash/splash_view.dart';
import 'services/http/getx_http.dart';
import 'services/language/language.dart';

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

  Get.lazyPut(() => LoadingController());
  Get.lazyPut(() => MyHttpProvider());

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

// import 'dart:math' as math;

// import 'package:flutter/material.dart';

// import 'package:swipable_stack/swipable_stack.dart';

// import 'components/card_swipe.dart';
// import 'services/constant.dart';


// const _images = [
//   'assets/imgs/img1.jpeg',
//   'assets/imgs/img2.jpeg',
//   'assets/imgs/img3.jpeg',
// ];

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late SwipableStackController _controller;

//   void _listenController() {
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = SwipableStackController()..addListener(_listenController);
//   }

//   static const double _bottomPadding = 100;
//   static const double _topPadding = 60;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('currentIndex:${_controller.currentIndex}'),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             SwipableStack(
//               controller: _controller,
//               onSwipeCompleted: (index, direction) {},
//               overlayBuilder: (
//                 context,
//                 constraints,
//                 index,
//                 direction,
//                 swipeProgress,
//               ) {
//                 final opacity = math.min(swipeProgress, 1.0);

//                 final isRight = direction == SwipeDirection.right;
//                 final isLeft = direction == SwipeDirection.left;
//                 final isUp = direction == SwipeDirection.up;
//                 final isDown = direction == SwipeDirection.down;
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                   ).copyWith(
//                     top: _topPadding + 8,
//                   ),
//                   child: Stack(
//                     children: [
//                       Opacity(
//                         opacity: isRight ? opacity : 0,
//                         child: CardLabel.right(),
//                       ),
//                       Opacity(
//                         opacity: isLeft ? opacity : 0,
//                         child: CardLabel.left(),
//                       ),
//                       Opacity(
//                         opacity: isUp ? opacity : 0,
//                         child: CardLabel.up(),
//                       ),
//                       Opacity(
//                         opacity: isDown ? opacity : 0,
//                         child: CardLabel.down(),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//               builder: (context, index, constraints) {
//                 final imagePath = _images[index % _images.length];
//                 return Padding(
//                   padding: const EdgeInsets.only(
//                     top: _topPadding,
//                     bottom: _bottomPadding,
//                   ),

//                   child: SingleChildScrollView(
//                       child: Column(children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.asset(
//                         imagePath,
//                       ),
//                     ),
//                     const Text('ok'),
//                     Container(
//                       height: 100,
//                       width: 100,
//                       color: Colors.red,
//                     ),
//                     Container(
//                       height: 100,
//                       width: 100,
//                       color: Colors.red,
//                     ),
//                     Container(
//                       height: 100,
//                       width: 100,
//                       color: Colors.red,
//                     ),
//                     Container(
//                       height: 100,
//                       width: 100,
//                       color: Colors.red,
//                     )
//                   ])),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.removeListener(_listenController);
//     _controller.dispose();
//   }
// }