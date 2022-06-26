import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'question1.dart';

class Question1View extends GetView<Question1Controller> {
  final Question1Controller c = Get.put(Question1Controller());

  Question1View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mBody(context),
    );
  }

  Widget mBody(context) {
    return Container(
      width: Get.width,
      color: AppTheme.colorWhite,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.statusBarHeight),
              SvgPicture.asset(
                'assets/svgs/logo_ngang.svg',
                height: 48,
                color: AppTheme.colorPrimary,
              ),
              const SizedBox(height: 32),
              TextCustom(
                'what_are_you_looking_for'.tr,
                style: AppTheme.textStyle16.bold().copyWith(fontSize: 22),
              ),
              const SizedBox(height: 4),
              TextCustom(
                'what_are_you_looking_for'.tr,
                style: AppTheme.textStyle16.medium(),
              ),
            ],
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppTheme.colorPrimary, width: 3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SvgPicture.asset('assets/svgs/editor.svg'),
                    ),
                    const SizedBox(height: 16),
                    TextCustom(
                      'creator'.tr,
                      style: AppTheme.textStyle16.bold().primary().italic(),
                    )
                  ],
                ),
                const SizedBox(width: 64),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppTheme.colorPrimary, width: 3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SvgPicture.asset('assets/svgs/client.svg'),
                    ),
                    const SizedBox(height: 16),
                    TextCustom(
                      'client'.tr,
                      style: AppTheme.textStyle16.bold().primary().italic(),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 64,
            child: SizedBox(
              child: Row(children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.colorSecondary,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.colorSecondary,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 8,
                  width: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.colorSecondary,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.colorSecondary,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppTheme.colorSecondary,
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
