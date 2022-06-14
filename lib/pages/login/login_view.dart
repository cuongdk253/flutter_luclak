import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
                        borderRadius: BorderRadius.circular(6),
                        color: AppTheme.colorWhite,
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 40,
                      child: Row(children: [
                        Obx(() => TextCustom(
                              '${c.countryCode.value} ${c.phoneCode.value}',
                              style: AppTheme.textStyle18.medium(),
                            )),
                        const SizedBox(width: 4),
                        SvgPicture.asset('assets/svgs/down.svg')
                      ]),
                    ),
                    onTap: () => c.onClickPhoneCode(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: c.phone,
                        style: AppTheme.textStyle18.medium(),
                        // autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
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
