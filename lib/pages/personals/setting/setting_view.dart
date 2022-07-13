import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'setting.dart';

class SettingView extends GetView<SettingController> {
  final SettingController c = Get.put(SettingController());

  SettingView({Key? key}) : super(key: key);

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
          margin:
              const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 12),
          decoration: BoxDecoration(
            color: AppTheme.colorBackgroundCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: List.generate(
              c.listSetting.length,
              (index) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: index != c.listSetting.length - 1
                    ? BoxDecoration(border: AppTheme.borderBottomLine)
                    : null,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            c.listSetting[index]['svg'],
                            color: AppTheme.colorText,
                          ),
                          const SizedBox(width: 8),
                          TextCustom(
                            c.listSetting[index]['title'],
                            style: AppTheme.textStyle16.medium(),
                          )
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/svgs/next.svg',
                        color: AppTheme.colorText,
                      )
                    ]),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.colorBackgroundCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: List.generate(
              c.listSetting1.length,
              (index) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: index != c.listSetting1.length - 1
                    ? BoxDecoration(border: AppTheme.borderBottomLine)
                    : null,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            c.listSetting1[index]['svg'],
                            color: AppTheme.colorText,
                          ),
                          const SizedBox(width: 8),
                          TextCustom(
                            c.listSetting1[index]['title'],
                            style: AppTheme.textStyle16.medium(),
                          )
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/svgs/next.svg',
                        color: AppTheme.colorText,
                      )
                    ]),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: AppTheme.colorBackgroundCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: List.generate(
              c.listSetting2.length,
              (index) => InkWell(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: index != c.listSetting2.length - 1
                      ? BoxDecoration(border: AppTheme.borderBottomLine)
                      : null,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              c.listSetting2[index]['svg'],
                              color: AppTheme.colorText,
                            ),
                            const SizedBox(width: 8),
                            TextCustom(
                              c.listSetting2[index]['title'],
                              style: AppTheme.textStyle16.medium(),
                            )
                          ],
                        ),
                        SvgPicture.asset(
                          'assets/svgs/next.svg',
                          color: AppTheme.colorText,
                        ),
                      ]),
                ),
                onTap: () => c.onClickLogout(),
              ),
            ),
          ),
        ),
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
            child: TextCustom(
              'Setting'.tr,
              style: AppTheme.textStyle18.medium(),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 25),
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
