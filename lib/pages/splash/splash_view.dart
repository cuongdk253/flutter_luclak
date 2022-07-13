import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../services/themes/app_theme.dart';
import 'splash.dart';

class SplashView extends GetView<SplashController> {
  final SplashController c = Get.put(SplashController());

  SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground1,
      body: mBody(),
    );
  }

  Widget mBody() {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/imgs/splash.png'),
            ),
          ),
        ),
        Container(
          width: Get.width,
          height: Get.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: AppTheme.gradient),
          child: SvgPicture.asset(
            'assets/svgs/logo_doc.svg',
            color: AppTheme.colorWhite,
          ),
        ),
      ],
    );
  }
}
