import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'fill_phone.dart';

class FillPhoneView extends GetView<FillPhoneController> {
  final FillPhoneController c = Get.put(FillPhoneController());

  FillPhoneView({Key? key}) : super(key: key);

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
              SizedBox(height: Get.statusBarHeight),
              Container(
                padding: const EdgeInsets.all(32),
                child: TextCustom(
                  'whats_your_number'.tr,
                  style: AppTheme.textStyle16.white().bold().copyWith(
                        fontSize: 30,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextCustom(
                  'send_otp'.tr,
                  style: AppTheme.textStyle16.white(),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  const SizedBox(width: 32),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppTheme.colorWhite,
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 44,
                      child: Row(children: [
                        Obx(() => TextCustom(
                              '${c.countryCode.value} ${c.phoneCode.value}',
                              style: AppTheme.textStyle18.medium().textDark(),
                            )),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/svgs/down.svg',
                          color: AppTheme.colorTextDark,
                        )
                      ]),
                    ),
                    onTap: () => c.onClickPhoneCode(),
                  ),
                  const SizedBox(width: 16),
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
                        controller: c.phone,
                        style: AppTheme.textStyle18.medium().textDark(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppTheme.colorWhite,
                          hintText: 'phone_number'.tr,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
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
