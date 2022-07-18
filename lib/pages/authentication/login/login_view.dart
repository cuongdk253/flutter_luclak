import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'login.dart';

class LoginView extends GetView<LoginController> {
  final LoginController c = Get.put(LoginController());

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mBody(context),
    );
  }

  Widget mBody(context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(gradient: AppTheme.gradient),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.25),
              Container(
                padding: const EdgeInsets.all(32),
                child: SvgPicture.asset('assets/svgs/logo_ngang.svg'),
              ),
              const SizedBox(height: 64),
              Container(
                height: 48,
                width: Get.width,
                margin: const EdgeInsets.only(left: 46, right: 46, bottom: 16),
                child: TextButton(
                  style: AppTheme.buttonPrimary.copyWith(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {},
                  child: TextCustom(
                    'login_by_apple'.tr,
                    style: AppTheme.textStyle18.bold().white(),
                  ),
                ),
              ),
              Container(
                height: 48,
                width: Get.width,
                margin: const EdgeInsets.only(left: 46, right: 46, bottom: 16),
                child: TextButton(
                  style: AppTheme.buttonPrimary.copyWith(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {},
                  child: TextCustom(
                    'login_by_google'.tr,
                    style: AppTheme.textStyle18.bold().blue(),
                  ),
                ),
              ),
              Container(
                height: 48,
                width: Get.width,
                margin: const EdgeInsets.only(left: 46, right: 46, bottom: 16),
                child: TextButton(
                  style: AppTheme.roundOulineButton.copyWith(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                      side: BorderSide(color: AppTheme.colorWhite, width: 2),
                    )),
                  ),
                  onPressed: () => c.onClickLoginByPhone(),
                  child: TextCustom(
                    'login_by_phone'.tr,
                    style: AppTheme.textStyle18.bold().white(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
