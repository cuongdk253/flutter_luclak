import 'package:appchat/components/text.dart';
import 'package:appchat/pages/filter/filter_view.dart';
import 'package:appchat/pages/personals/balance/balance_view.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HeaderBarController extends GetxController {
  onClickLogoFlash() {
    Get.bottomSheet(
      SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: AppTheme.colorBackgroundDark),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/svgs/close.svg',
                        color: AppTheme.colorWhite,
                      ),
                      onTap: () => Get.back(),
                    ),
                    Expanded(
                      child: TextCustom(
                        'push_time'.tr,
                        style: AppTheme.textStyle20.bold(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 24)
                  ],
                ),
                const SizedBox(height: 12),
                TextCustom(
                  'des_push_time'.tr,
                  style: AppTheme.textStyle16,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _coinCard(),
                    const SizedBox(width: 8),
                    _coinCard(
                      popular: true,
                      type: 'normal',
                      amount: 5,
                      cost: 450,
                    ),
                    const SizedBox(width: 8),
                    _coinCard(
                      type: 'alot',
                      amount: 50,
                      cost: 2500,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: 50,
                      color: AppTheme.colorGreyText,
                    ),
                    const SizedBox(width: 12),
                    TextCustom(
                      'OR'.tr,
                      style: AppTheme.textStyle20.bold().grey(),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 2,
                      width: 50,
                      color: AppTheme.colorGreyText,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                InkWell(
                  child: Container(
                    height: 44,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: AppTheme.gradient),
                    child: TextCustom(
                      'buy_luclak_premium'.tr,
                      style: AppTheme.textStyle18.bold().white(),
                    ),
                  ),
                  // onTap: () => c.onClickNext(),
                ),
                const SizedBox(height: 12),
                TextCustom(
                  'one_free_push_per_month'.tr,
                  style: AppTheme.textStyleSub,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
              ],
            ),
          )
        ]),
      ),
      isScrollControlled: true,
    );
  }

  Widget _coinCard({
    bool popular = false,
    String type = 'less',
    int amount = 1,
    int cost = 100,
  }) {
    return Container(
      width: (Get.width - 56) / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppTheme.colorBackgroundCard,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            popular
                ? Container(
                    height: 24,
                    width: (Get.width - 56) / 3,
                    color: AppTheme.colorYellow,
                    child: TextCustom(
                      'popular'.tr,
                      style: AppTheme.textStyle.medium(),
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox(height: 24),
            const SizedBox(height: 4),
            TextCustom(
              amount.toString(),
              style: AppTheme.textStyle18.bold(),
            ),
            const SizedBox(height: 16),
            Container(
              height: 50,
              width: 44,
              padding: const EdgeInsets.all(1),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Positioned(
                    bottom: 1.5,
                    child:
                        _coin(isMany: type != 'less', showCoin: type == 'less'),
                  ),
                  type != 'less'
                      ? Positioned(
                          bottom: 6,
                          child: _coin(),
                        )
                      : const SizedBox(),
                  type != 'less'
                      ? Positioned(
                          bottom: 10,
                          child: _coin(showCoin: type == 'normal'),
                        )
                      : const SizedBox(),
                  type == 'alot'
                      ? Positioned(
                          bottom: 14,
                          child: _coin(),
                        )
                      : const SizedBox(),
                  type == 'alot'
                      ? Positioned(
                          bottom: 18,
                          child: _coin(showCoin: type == 'alot'),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 30,
              width: (Get.width - 56) / 3,
              color: AppTheme.colorPrimary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/coin.svg',
                    height: 15,
                  ),
                  const SizedBox(width: 4),
                  TextCustom(
                    '500/${'turn'.tr}',
                    style: AppTheme.textStyle.medium(),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _coin({bool showCoin = false, bool isMany = true}) {
    return Container(
      width: 40.0,
      height: isMany ? 27.0 : 34.0,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.elliptical(40, isMany ? 27.0 : 34.0)),
        gradient: AppTheme.gradient,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0.0, 1.0),
            color: Colors.black.withOpacity(.5),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: showCoin
          ? isMany
              ? SvgPicture.asset('assets/svgs/flash2.svg')
              : SvgPicture.asset('assets/svgs/flash1.svg')
          : const SizedBox(),
    );
  }

  onClickBalance() {
    Get.to(() => BalanceView());
  }

  onClickLogo() {
    Get.to(() => FilterView());
  }
}
