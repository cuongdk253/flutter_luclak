import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'otp.dart';

class OtpView extends GetView<OtpController> {
  final OtpController c = Get.put(OtpController());

  OtpView({Key? key}) : super(key: key);

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
                  'verify_your_number'.tr,
                  style: AppTheme.textStyle16.white().bold().copyWith(
                        fontSize: 30,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: RichText(
                  text: TextSpan(
                      text: '${'fill_otp'.tr} ',
                      style: AppTheme.textStyle16.white(),
                      children: [
                        TextSpan(
                            text: 'change'.tr,
                            style: AppTheme.textStyle16.white().bold().copyWith(
                                  decoration: TextDecoration.underline,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => c.onClickBack())
                      ]),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _pinCode(context),
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
              onTap: () => c.onClickVerification(),
            ),
          )
        ],
      ),
    );
  }

  Widget _pinCode(context) {
    return PinCodeTextField(
      controller: c.otp,
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      cursorColor: AppTheme.colorTextDark,
      cursorHeight: 18,
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: false),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: AppTheme.colorWhite,
        activeColor: AppTheme.colorWhite,
        inactiveFillColor: AppTheme.colorWhite,
        inactiveColor: AppTheme.colorWhite,
        selectedFillColor: AppTheme.colorWhite,
        selectedColor: AppTheme.colorWhite,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      onChanged: (value) {},
      onCompleted: (value) {
        c.onClickVerification();
      },
    );
  }
}
