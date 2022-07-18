import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'safe.dart';

class SafeView extends GetView<SafeController> {
  final SafeController c = Get.put(SafeController());

  SafeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackgroundDark,
      appBar: mAppBar(),
      body: mBody(),
    );
  }

  Widget mBody() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
          child: InkWell(
            child: Container(
              height: 44,
              width: Get.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: AppTheme.gradient),
              child: TextCustom(
                'get_help_form_luclak'.tr,
                style: AppTheme.textStyle18.bold().white(),
              ),
            ),
            onTap: () => {},
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppTheme.colorBackgroundCard,
          ),
          child: Row(children: [
            SvgPicture.asset('assets/svgs/shield1.svg'),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    'your_safety'.tr,
                    style: AppTheme.textStyle16.medium(),
                  ),
                  TextCustom(
                    'des_your_safety'.tr,
                    style: AppTheme.textStyle.grey(),
                  )
                ],
              ),
            )
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppTheme.colorBackgroundCard,
          ),
          child: Row(children: [
            SvgPicture.asset('assets/svgs/heart1.svg'),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    'your_inmotional'.tr,
                    style: AppTheme.textStyle16.medium(),
                  ),
                  TextCustom(
                    'des_your_inmotional'.tr,
                    style: AppTheme.textStyle.grey(),
                  )
                ],
              ),
            )
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.colorGreyText1),
          ),
          child: Row(children: [
            SvgPicture.asset('assets/svgs/shield1.svg'),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    'luclak_guildlines'.tr,
                    style: AppTheme.textStyle16.medium(),
                  ),
                  TextCustom(
                    'des_luclak_guildlines'.tr,
                    style: AppTheme.textStyle.grey(),
                  )
                ],
              ),
            )
          ]),
        )
      ],
    );
  }

  AppBar mAppBar() {
    return AppBar(
      backgroundColor: AppTheme.colorBackgroundHeader,
      leading: const SizedBox(),
      centerTitle: true,
      leadingWidth: 0,
      elevation: 0,
      title: Row(
        children: [
          InkWell(
            child: SvgPicture.asset(
              'assets/svgs/back.svg',
              color: AppTheme.colorText,
            ),
            onTap: () => c.onClickBack(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextCustom(
                  '${c.personalController.user.fullName}, ${c.personalController.user.age}',
                  style: AppTheme.textStyle18.medium(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 12),
                SvgPicture.asset('assets/svgs/shield.svg')
              ],
            ),
          ),
          const SizedBox(width: 24),
        ],
      ),
      bottom: PreferredSize(
        child: Container(
          color: AppTheme.colorGreyText1,
          height: 1.0,
        ),
        preferredSize: const Size.fromHeight(1.0),
      ),
    );
  }
}
