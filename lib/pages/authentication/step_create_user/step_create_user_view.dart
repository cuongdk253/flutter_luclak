import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/check.dart';
import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'step_create_user.dart';

class StepCreateUserView extends GetView<StepCreateUserController> {
  final StepCreateUserController c = Get.put(StepCreateUserController());

  StepCreateUserView({Key? key}) : super(key: key);

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
            child: Obx(() => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
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
              } else if (c.step.value == 4) {
                return _step4();
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
            'what_first_name'.tr,
            style: AppTheme.textStyle16.white().bold().copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextCustom(
            'cant_change_later'.tr,
            style: AppTheme.textStyle16.white(),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            const SizedBox(width: 32),
            Expanded(
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorWhite,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: c.fullName,
                  style: AppTheme.textStyle18.medium().textDark(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppTheme.colorWhite,
                    hintText: 'add_your_first_name'.tr,
                  ),
                  onChanged: (value) => c.onChangeName(),
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
            'what_your_birthday'.tr,
            style: AppTheme.textStyle16.white().bold().copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextCustom(
            'des_your_birthday'.tr,
            style: AppTheme.textStyle16.white(),
          ),
        ),
        const SizedBox(height: 64),
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 44,
                width: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorWhite,
                ),
                alignment: Alignment.center,
                child: Obx(() => TextCustom(
                      c.birthDay.value,
                      style: AppTheme.textStyle18.bold().textDark(),
                    )),
              ),
              const SizedBox(width: 20),
              Container(
                height: 44,
                width: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorWhite,
                ),
                alignment: Alignment.center,
                child: Obx(() => TextCustom(
                      c.birthMonth.value,
                      style: AppTheme.textStyle18.bold().textDark(),
                    )),
              ),
              const SizedBox(width: 20),
              Container(
                height: 44,
                width: 76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorWhite,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                child: Obx(() => TextCustom(
                      c.birthYear.value,
                      style: AppTheme.textStyle18.bold().textDark(),
                    )),
              ),
            ],
          ),
          onTap: () => c.onClickBirthday(),
        )
      ],
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
            'what_your_gender'.tr,
            style: AppTheme.textStyle16.white().bold().copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextCustom(
            'des_what_your_gender'.tr,
            style: AppTheme.textStyle16.white(),
          ),
        ),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Obx(() => Column(
                children: List.generate(
                    c.listGender.length,
                    (index) => InkWell(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppTheme.colorWhite,
                            ),
                            child: Row(children: [
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextCustom(
                                  c.listGender[index]['name'],
                                  style: AppTheme.textStyle18.bold().textDark(),
                                ),
                              ),
                              MyCheckbox(
                                isChecked: c.listGender[index]['code'] ==
                                    c.genderCode.value,
                                unSelectedColor: AppTheme.colorGreyText,
                              ),
                              const SizedBox(width: 12),
                            ]),
                          ),
                          onTap: () =>
                              c.onClickGender(c.listGender[index]['code']),
                        )),
              )),
        ),
      ],
    );
  }

  Widget _step4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Get.statusBarHeight),
        Container(
          padding: const EdgeInsets.all(32),
          child: TextCustom(
            'choose_mode_to_start'.tr,
            style: AppTheme.textStyle16.white().bold().copyWith(
                  fontSize: 30,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: TextCustom(
            'des_choose_mode_to_start'.tr,
            style: AppTheme.textStyle16.white(),
          ),
        ),
        const SizedBox(height: 32),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Obx(
              () => Column(
                  children: List.generate(
                c.listUserType.length,
                (index) => InkWell(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppTheme.colorWhite,
                    ),
                    child: Row(children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              c.listUserType[index]['name'],
                              style: AppTheme.textStyle18.bold().textDark(),
                            ),
                            const SizedBox(height: 4),
                            TextCustom(
                              c.listUserType[index]['description'],
                              style: AppTheme.textStyle16.textDark(),
                            )
                          ],
                        ),
                      ),
                      MyCheckbox(
                        isChecked: c.listUserType[index]['code'] ==
                            c.userTypeCode.value,
                        unSelectedColor: AppTheme.colorGreyText,
                      ),
                      const SizedBox(width: 12),
                    ]),
                  ),
                  onTap: () => c.onClickUserType(c.listUserType[index]['code']),
                ),
              )),
            )),
      ],
    );
  }
}
