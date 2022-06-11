import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
    return SizedBox(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.statusBarHeight),
              Container(
                padding: const EdgeInsets.all(32),
                child: TextCustom(
                  "Verify your number",
                  style: AppTheme.textStyle16.white().bold().copyWith(
                        fontSize: 30,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: RichText(
                  text: TextSpan(
                      text:
                          'Enter the code we’ve sent by text to +84398498960. ',
                      style: AppTheme.textStyle16.white(),
                      children: [
                        TextSpan(
                            text: 'Change',
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
      keyboardType:
          const TextInputType.numberWithOptions(signed: true, decimal: false),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
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
        // c.onClickVerification(value);
      },
    );
  }
}
