import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'question2.dart';

class Question2View extends GetView<Question2Controller> {
  final Question2Controller c = Get.put(Question2Controller());

  Question2View({Key? key}) : super(key: key);

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
                'what_are_your_preferences'.tr,
                style: AppTheme.textStyle16.bold().copyWith(fontSize: 22),
              ),
              const SizedBox(height: 4),
              TextCustom(
                'select_your_info_and_pudget'.tr,
                style: AppTheme.textStyle16.medium(),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextCustom(
                      'your_pudget'.tr,
                      style: AppTheme.textStyle16.bold().primary().italic(),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.colorBackground),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(children: [
                            TextCustom(
                              '\$0',
                              style: AppTheme.textStyle16.grey(),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset('assets/svgs/down1.svg')
                          ]),
                        ),
                        Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.colorBackground),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(children: [
                            TextCustom(
                              '\$10k+',
                              style: AppTheme.textStyle16.grey(),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset('assets/svgs/down1.svg')
                          ]),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Obx(() => RangeSlider(
                          values:
                              RangeValues(c.minPudget.value, c.maxPudget.value),
                          max: 100,
                          divisions: 100,
                          onChanged: (RangeValues value) {
                            c.minPudget.value = value.start;
                            c.maxPudget.value = value.end;
                          },
                        ))
                  ],
                ),
              )
            ],
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
              ]),
            ),
          )
        ],
      ),
    );
  }
}
