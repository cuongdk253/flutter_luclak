import 'package:appchat/components/check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'filter.dart';

class FilterLanguageView extends StatelessWidget {
  final FilterController c = Get.find();

  FilterLanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colorBackgroundDark,
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(Get.context!).padding.top),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: SvgPicture.asset(
                    'assets/svgs/back.svg',
                    color: AppTheme.colorText,
                  ),
                  onTap: () => c.onClickBack(),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 24),
            child: TextCustom(
              'location_booking'.tr,
              style: AppTheme.textStyle.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 44,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppTheme.colorGreyText1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            alignment: Alignment.center,
            child: TextFormField(
              style: AppTheme.textStyle16.medium(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isDense: true,
                border: InputBorder.none,
                filled: true,
                fillColor: AppTheme.colorGreyText1,
                hintText: 'location_search'.tr,
                hintStyle: AppTheme.textStyle16.grey(),
              ),
              onChanged: (value) => c.onLanguageChange(value),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: GetBuilder<FilterController>(
                builder: (_) => Column(
                  children: List.generate(
                    c.listLanguageShow.length,
                    (index) => InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Row(children: [
                          MyCheckbox(
                            isChecked:
                                c.listLanguageShow[index]['checked'] ?? false,
                            circle: false,
                          ),
                          const SizedBox(width: 16),
                          TextCustom(
                            c.listLanguageShow[index]['name'],
                            style: AppTheme.textStyle16,
                          )
                        ]),
                      ),
                      onTap: () => c.onClickLanguageItem(index),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
            child: InkWell(
              child: Container(
                height: 44,
                width: Get.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    gradient: AppTheme.gradient),
                child: TextCustom(
                  'next'.tr,
                  style: AppTheme.textStyle18.bold().white(),
                ),
              ),
              onTap: () => c.onClickDoneFilterLanguage(),
            ),
          )
        ],
      ),
    );
  }
}
