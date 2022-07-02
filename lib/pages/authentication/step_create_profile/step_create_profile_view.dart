import 'package:appchat/components/check.dart';
import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/radio.dart';
import 'step_create_profile.dart';

class StepCreateProfileView extends GetView<StepCreateProfileController> {
  final StepCreateProfileController c = Get.put(StepCreateProfileController());

  StepCreateProfileView({Key? key}) : super(key: key);

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
          Container(
            height: 6,
            width: Get.width,
            margin: EdgeInsets.only(
              top: MediaQuery.of(Get.context!).padding.top + 16,
              left: 32,
              right: 32,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: Colors.white.withOpacity(0.5)),
            child: Obx(() => Container(
                  margin: EdgeInsets.only(
                      right: (Get.width - 64) * (1 - c.processStep.value)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white),
                )),
          ),
          // _step1(),
          _step2(),
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
          ),
          Positioned(
            bottom: 48,
            left: 32,
            child: InkWell(
              child: TextCustom(
                'skip'.tr,
                style: AppTheme.textStyle16.bold().white(),
              ),
              onTap: () => c.onClickNext(),
            ),
          )
        ],
      ),
    );
  }

  Widget _step1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.statusBarHeight),
        Container(
          padding: const EdgeInsets.all(32),
          child: TextCustom(
            'add_more_about_you'.tr,
            style: AppTheme.textStyle16.white().bold().copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextCustom(
            'des_add_more_about_you'.tr,
            style: AppTheme.textStyle16.white(),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            const SizedBox(width: 32),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorWhite,
                ),
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: c.aboutYou,
                  style: AppTheme.textStyle18.medium(),
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppTheme.colorWhite,
                    hintText: 'add_your_first_name'.tr,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 32),
          ],
        )
      ],
    );
  }

  Widget _step2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.statusBarHeight),
        Container(
          padding: const EdgeInsets.all(32),
          child: TextCustom(
            'your_power'.tr,
            style: AppTheme.textStyle16.white().bold().copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextCustom(
            'des_your_power'.tr,
            style: AppTheme.textStyle16.white(),
          ),
        ),
        const SizedBox(height: 32),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: GetBuilder<StepCreateProfileController>(
              builder: (_) => Wrap(
                  children: List.generate(
                c.listPower.length,
                (index) => InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16, right: 16),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.colorWhite.withOpacity(
                          c.listPower[index]['checked'] == true ? 1.0 : 0.5),
                    ),
                    child: TextCustom(
                      c.listPower[index]['name'],
                      style: AppTheme.textStyle16.medium(),
                    ),
                  ),
                  onTap: () => c.onClickPower(index),
                ),
              )),
            )),
      ],
    );
  }
}
