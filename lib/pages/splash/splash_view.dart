import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
    return SizedBox(
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 48),
              child: SvgPicture.asset('assets/svgs/logo_doc.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
