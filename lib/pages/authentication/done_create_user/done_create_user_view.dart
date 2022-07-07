import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'done_create_user.dart';

class DoneCreateUserView extends GetView<DoneCreateUserController> {
  final DoneCreateUserController c = Get.put(DoneCreateUserController());

  DoneCreateUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: mBody(context),
      ),
    );
  }

  Widget mBody(context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(color: AppTheme.colorWhite),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.statusBarHeight + 80),
              ShaderMask(
                shaderCallback: (bounds) {
                  return AppTheme.gradient.createShader(bounds);
                },
                child: SvgPicture.asset(
                  'assets/svgs/logo_doc.svg',
                  color: AppTheme.colorWhite,
                ),
              ),
            ],
          ),
          Positioned(
            right: 32,
            left: 32,
            bottom: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextCustom(
                  'you_are_here'.tr,
                  style: AppTheme.textStyle
                      .bold()
                      .textDark()
                      .copyWith(fontSize: 30),
                ),
                const SizedBox(height: 16),
                TextCustom(
                  'des_you_are_here'.tr,
                  style: AppTheme.textStyle18.textDark(),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            right: 32,
            left: 32,
            child: InkWell(
              child: Container(
                height: 44,
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: AppTheme.gradient),
                child: TextCustom(
                  'build_profile'.tr,
                  style: AppTheme.textStyle18.bold().white(),
                ),
              ),
              onTap: () => c.onClickNext(),
            ),
          )
        ],
      ),
    );
  }
}
