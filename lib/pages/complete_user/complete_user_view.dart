import 'package:appchat/components/radio.dart';
import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'complete_user.dart';

class CompleteUserView extends GetView<CompleteUserController> {
  final CompleteUserController c = Get.put(CompleteUserController());

  CompleteUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorPrimary,
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
              SizedBox(height: Get.statusBarHeight),
              Container(
                padding: const EdgeInsets.all(32),
                child: TextCustom(
                  'user_info'.tr,
                  style: AppTheme.textStyle16.white().bold().copyWith(
                        fontSize: 30,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      'name'.tr,
                      style: AppTheme.textStyle16.white().medium(),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: c.name,
                        style: AppTheme.textStyle18.medium(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          isDense: true,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppTheme.colorBorder),
                              borderRadius: BorderRadius.circular(6)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppTheme.colorBorder),
                              borderRadius: BorderRadius.circular(6)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppTheme.colorBorder),
                              borderRadius: BorderRadius.circular(6)),
                          filled: true,
                          fillColor: AppTheme.colorWhite,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(
                        'birth'.tr,
                        style: AppTheme.textStyle16.white().medium(),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 40,
                        child: Obx(() => TextCustom(
                              c.birth.value,
                              style: AppTheme.textStyle18.white().bold(),
                            )),
                      ),
                    ],
                  ),
                ),
                onTap: () => c.onClickChangeBirth(),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      'you_are'.tr,
                      style: AppTheme.textStyle16.white().medium(),
                    ),
                    const SizedBox(height: 8),
                    Obx(() => Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Row(
                                  children: [
                                    MyRadiobox(
                                        isChecked: (c.userType.value == 'kol')),
                                    const SizedBox(width: 8),
                                    TextCustom(
                                      'KOL',
                                      style:
                                          AppTheme.textStyle16.medium().white(),
                                    )
                                  ],
                                ),
                                onTap: () => c.userType.value = 'kol',
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Row(
                                  children: [
                                    MyRadiobox(
                                        isChecked:
                                            (c.userType.value == 'creator')),
                                    const SizedBox(width: 8),
                                    TextCustom(
                                      'Creator',
                                      style:
                                          AppTheme.textStyle16.medium().white(),
                                    )
                                  ],
                                ),
                                onTap: () => c.userType.value = 'creator',
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: InkWell(
              child: Container(
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: AppTheme.colorWhite,
                ),
                child: SvgPicture.asset('assets/svgs/next.svg'),
              ),
              onTap: () => c.onClickNext(),
            ),
          )
        ],
      ),
    );
  }
}
