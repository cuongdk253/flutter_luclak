import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/http/cmd.dart';
import '../../../services/themes/app_theme.dart';
import 'step_create_profile.dart';

class StepCreateProfileView extends GetView<StepCreateProfileController> {
  final StepCreateProfileController c = Get.put(StepCreateProfileController());

  StepCreateProfileView({Key? key}) : super(key: key);

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
          SlideTransition(
            position: c.offsetAnimation,
            child: Obx(() {
              if (c.step.value == 1) {
                return _step1();
              } else if (c.step.value == 2) {
                return _step2();
              } else if (c.step.value == 3) {
                return _step3();
              }
              return Container();
            }),
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: InkWell(
              child: Obx(() => Opacity(
                    opacity: c.canNext.value ? 1.0 : 0.5,
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
                  )),
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
                  style: AppTheme.textStyle18.medium().textDark(),
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppTheme.colorWhite,
                    hintText: 'add_your_description'.tr,
                  ),
                  onChanged: (value) => c.onChangeAbout(),
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
            'add_first_2_photo'.tr,
            style: AppTheme.textStyle16.white().bold().copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextCustom(
            'des_add_2_photo'.tr,
            style: AppTheme.textStyle16.white(),
          ),
        ),
        const SizedBox(height: 64),
        Expanded(
          child: GetBuilder<StepCreateProfileController>(
            id: c.idUpdateImage,
            builder: (_) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 32),
                Expanded(child: _step2Image(0)),
                const SizedBox(width: 16),
                Expanded(child: _step2Image(1)),
                const SizedBox(width: 32),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _step2Image(index) {
    var item = c.listImage[index];
    return InkWell(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: (Get.width - 80) * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppTheme.colorBackground),
                color: AppTheme.colorBackground,
                image: item['image_url'] != ''
                    ? DecorationImage(
                        image: NetworkImage(baseUrl + item['image_url']),
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
          Positioned(
            top: 0,
            child: Obx(() => item['uploading'].value == true
                ? Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        height: (Get.width - 80) * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          backgroundColor: AppTheme.colorWhite.withOpacity(0.3),
                          color: AppTheme.colorPrimary,
                          value: item['process'].value,
                        ),
                      ),
                    ],
                  )
                : item['image_url'] == ''
                    ? SizedBox(
                        height: (Get.width - 80) * 0.6,
                        child: SvgPicture.asset(
                          'assets/svgs/plus.svg',
                          color: AppTheme.colorGreyText,
                        ),
                      )
                    : const SizedBox()),
          )
        ],
      ),
      onTap: () => c.onClickImage(index),
    );
  }

  Widget _step3() {
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
                      style: AppTheme.textStyle16.medium().textDark(),
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
