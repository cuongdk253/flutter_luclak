import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../services/themes/app_theme.dart';
import 'header_bar.dart';

class HeaderBarView extends GetView<HeaderBarController>
    with PreferredSizeWidget {
  final HeaderBarController c = Get.put(HeaderBarController());

  HeaderBarView({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.colorBackgroundHeader,
      centerTitle: true,
      leadingWidth: 0,
      elevation: 0,
      leading: const SizedBox(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: Container(
              width: 60,
              alignment: Alignment.centerLeft,
              child: InkWell(
                child: SvgPicture.asset('assets/svgs/flash.svg'),
              ),
            ),
            onTap: () => c.onClickLogoFlash(),
          ),
          InkWell(
            child: ShaderMask(
              shaderCallback: (bounds) {
                return AppTheme.gradient.createShader(bounds);
              },
              child: SvgPicture.asset(
                'assets/svgs/logo_text.svg',
                height: 30,
                color: AppTheme.colorWhite,
              ),
            ),
            onTap: () => c.onClickLogo(),
          ),
          InkWell(
            child: Container(
              height: 32,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppTheme.colorGreyText)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppTheme.colorBackgroundCard),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/coin.svg',
                      height: 14,
                    ),
                    const SizedBox(width: 3),
                    TextCustom(
                      '10',
                      style: AppTheme.textStyle.bold(),
                    )
                  ],
                ),
              ),
            ),
            onTap: () => c.onClickBalance(),
          )
        ],
      ),
    );
  }
}
