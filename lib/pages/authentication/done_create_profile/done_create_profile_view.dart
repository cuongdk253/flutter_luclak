import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'done_create_profile.dart';

class DoneCreateProfileView extends GetView<DoneCreateProfileController> {
  final DoneCreateProfileController c = Get.put(DoneCreateProfileController());

  DoneCreateProfileView({Key? key}) : super(key: key);

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
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.statusBarHeight),
                TextCustom(
                  'its_to_be_coll'.tr,
                  style:
                      AppTheme.textStyle.bold().white().copyWith(fontSize: 36),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextCustom(
                  'des_its_to_be_coll'.tr,
                  style: AppTheme.textStyle16.white(),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            child: InkWell(
              child: Container(
                height: 44,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: AppTheme.colorWhite),
                child: TextCustom(
                  'i_agree'.tr,
                  style: AppTheme.textStyle16.bold().textDark(),
                ),
              ),
              onTap: () => c.onClickNext(),
            ),
          )
        ],
      ),
    );
  }
}
