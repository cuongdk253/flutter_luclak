import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'balance.dart';

class BalanceView extends GetView<BalanceController> {
  final BalanceController c = Get.put(BalanceController());

  BalanceView({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: AppTheme.borderBottomLine,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                'payout'.tr,
                style: AppTheme.textStyle16.medium(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/coin.svg',
                          height: 24,
                        ),
                        const SizedBox(width: 8),
                        TextCustom(
                          '10',
                          style:
                              AppTheme.textStyle.bold().copyWith(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    child: Container(
                      height: 36,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: AppTheme.gradient),
                      child: TextCustom(
                        'payout'.tr,
                        style: AppTheme.textStyle16.bold().white(),
                      ),
                    ),
                    onTap: () => {},
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: AppTheme.borderBottomLine,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextCustom(
                  'gift_revenue'.tr,
                  style: AppTheme.textStyle16,
                ),
              ),
              Row(
                children: [
                  TextCustom(
                    '\$19',
                    style: AppTheme.textStyle16,
                  ),
                  SvgPicture.asset(
                    'assets/svgs/next.svg',
                    color: AppTheme.colorText,
                  )
                ],
              )
            ],
          ),
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
            child: TextCustom(
              'balance'.tr,
              style: AppTheme.textStyle18.medium(),
              textAlign: TextAlign.center,
            ),
          ),
          SvgPicture.asset('assets/svgs/checklist.svg')
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
