import 'package:appchat/components/check.dart';
import 'package:appchat/components/format_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../components/toggle.dart';
import '../../../services/themes/app_theme.dart';
import 'filter.dart';

class FilterView extends GetView<FilterController> {
  final FilterController c = Get.put(FilterController());

  FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackgroundHeader,
      appBar: mAppBar(),
      body: mBody(),
      bottomNavigationBar: mBottomBar(),
    );
  }

  AppBar mAppBar() {
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
            child: SvgPicture.asset(
              'assets/svgs/back.svg',
              color: AppTheme.colorText,
            ),
            onTap: () => c.onClickBack(),
          ),
          TextCustom(
            'match_filter'.tr,
            style: AppTheme.textStyle.copyWith(fontSize: 24),
          ),
          const SizedBox(width: 24),
        ],
      ),
      bottom: PreferredSize(
        child: Container(
          color: AppTheme.colorGreyText,
          height: 1.0,
        ),
        preferredSize: const Size.fromHeight(3.0),
      ),
    );
  }

  Widget mBody() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 20),
      children: [
        const SizedBox(height: 8),
        _whoWantBook(),
        _age(),
        _pubget(),
        // _location(),
        _language(),
        // _advance(),
      ],
    );
  }

  Widget mBottomBar() {
    return Obx(() => c.filterChange.value
        ? SafeArea(
            child: Container(
              decoration: BoxDecoration(border: AppTheme.borderTopLine),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                onTap: () => c.onClickApplyFilter(),
              ),
            ),
          )
        : const SizedBox());
  }

  Widget _language() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              TextCustom(
                'language'.tr,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colorBackgroundCard,
            ),
            child: InkWell(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(() => TextCustom(
                            c.languageSort.value,
                            style: AppTheme.textStyle.copyWith(fontSize: 16),
                          )),
                    ),
                    SvgPicture.asset(
                      'assets/svgs/next.svg',
                      color: AppTheme.colorGreyText,
                    ),
                  ],
                ),
              ),
              onTap: () => c.onFilterViewLanguage(),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _advance() {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             const SizedBox(width: 8),
  //             TextCustom(
  //               'filters'.tr,
  //               style: const TextStyle(color: Colors.grey),
  //             )
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: AppTheme.colorBackgroundCard,
  //           ),
  //           child: InkWell(
  //             child: Container(
  //               padding: const EdgeInsets.all(12),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Expanded(
  //                     child: TextCustom(
  //                       'adv_filters'.tr,
  //                       style: AppTheme.textStyle.copyWith(fontSize: 16),
  //                     ),
  //                   ),
  //                   SvgPicture.asset(
  //                     'assets/svgs/next.svg',
  //                     color: AppTheme.colorGreyText,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             onTap: () => c.onFilterViewLocation(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _location() {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             const SizedBox(width: 8),
  //             TextCustom(
  //               'location'.tr,
  //               style: const TextStyle(color: Colors.grey),
  //             )
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Container(
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: AppTheme.colorBackgroundCard,
  //           ),
  //           child: InkWell(
  //             child: Container(
  //               padding: const EdgeInsets.all(12),
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Expanded(
  //                     child: TextCustom(
  //                       'select_location'.tr,
  //                       style: AppTheme.textStyle.copyWith(fontSize: 16),
  //                     ),
  //                   ),
  //                   SvgPicture.asset(
  //                     'assets/svgs/next.svg',
  //                     color: AppTheme.colorGreyText,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             onTap: () => c.onFilterViewLocation(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _pubget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              TextCustom(
                'your_budget'.tr,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colorBackgroundCard,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: AppTheme.colorText,
                            ),
                          ),
                          child: Row(children: [
                            Obx(() => TextCustom(
                                  '\$ ${formatNumberString(c.pubgetStart.value)}',
                                  style: AppTheme.textStyle16,
                                )),
                            const SizedBox(width: 6),
                            SvgPicture.asset(
                              'assets/svgs/down1.svg',
                              color: AppTheme.colorText,
                            )
                          ]),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: AppTheme.colorText,
                            ),
                          ),
                          child: Row(children: [
                            Obx(() => TextCustom(
                                  '\$ ${formatNumberString(c.pubgetEnd.value)}' +
                                      (c.pubgetEnd.value == c.maxPubget
                                          ? ' +'
                                          : ''),
                                  style: AppTheme.textStyle16,
                                )),
                            const SizedBox(width: 6),
                            SvgPicture.asset(
                              'assets/svgs/down1.svg',
                              color: AppTheme.colorText,
                            )
                          ]),
                        ),
                      ],
                    ),
                    onTap: () => c.onClickPubget(),
                  ),
                ),
                Obx(() => RangeSlider(
                    values: RangeValues(c.pubgetStart.value, c.pubgetEnd.value),
                    max: c.maxPubget,
                    activeColor: AppTheme.colorPrimary,
                    inactiveColor: AppTheme.colorWhite.withOpacity(0.5),
                    labels: RangeLabels(
                      c.pubgetStart.value.round().toString(),
                      c.pubgetEnd.value.round().toString(),
                    ),
                    onChanged: (RangeValues values) =>
                        c.onPubgetChange(values))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _age() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              TextCustom(
                'age'.tr,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colorBackgroundCard,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
                  child: Obx(() => TextCustom(
                        '${'between'.tr} ${c.minAge.value.round().toString()} ${'and'.tr} ${c.maxAge.value.round().toString()}',
                        style: AppTheme.textStyle.copyWith(fontSize: 16),
                      )),
                ),
                Obx(() => RangeSlider(
                    values: RangeValues(c.minAge.value, c.maxAge.value),
                    max: 100,
                    activeColor: AppTheme.colorPrimary,
                    inactiveColor: AppTheme.colorWhite.withOpacity(0.5),
                    labels: RangeLabels(
                      c.minAge.value.round().toString(),
                      c.maxAge.value.round().toString(),
                    ),
                    onChanged: (RangeValues values) => c.onAgeChange(values))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _whoWantBook() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              TextCustom(
                'who_wanna_book'.tr,
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colorBackgroundCard,
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(border: AppTheme.borderBottomLine),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextCustom(
                          'ok_with_everyone'.tr,
                          style: AppTheme.textStyle16,
                        ),
                      ),
                      InkWell(
                        child: Obx(() => MyToggle(
                              selectedColor: AppTheme.colorPrimary,
                              size: 30,
                              isOn: c.checkToggle.value,
                            )),
                        onTap: () => c.onChangeToggle(),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  child: Container(
                    decoration:
                        BoxDecoration(border: AppTheme.borderBottomLine),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextCustom(
                            'man'.tr,
                            style: AppTheme.textStyle16,
                          ),
                        ),
                        Obx(() => MyCheckbox(
                              selectedColor: AppTheme.colorPrimary,
                              isChecked: c.checkMan.value,
                              circle: false,
                            ))
                      ],
                    ),
                  ),
                  onTap: () => c.onCheckMan(),
                ),
                InkWell(
                  child: Container(
                    decoration:
                        BoxDecoration(border: AppTheme.borderBottomLine),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextCustom(
                            'women'.tr,
                            style: AppTheme.textStyle16,
                          ),
                        ),
                        Obx(() => MyCheckbox(
                              selectedColor: AppTheme.colorPrimary,
                              isChecked: c.checkWoman.value,
                              circle: false,
                            ))
                      ],
                    ),
                  ),
                  onTap: () => c.onCheckWoman(),
                ),
                InkWell(
                  child: Container(
                    decoration:
                        BoxDecoration(border: AppTheme.borderBottomLine),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextCustom(
                            'nonbinary'.tr,
                            style: AppTheme.textStyle16,
                          ),
                        ),
                        Obx(() => MyCheckbox(
                              selectedColor: AppTheme.colorPrimary,
                              isChecked: c.checkOther.value,
                              circle: false,
                            ))
                      ],
                    ),
                  ),
                  onTap: () => c.onCheckNonbinary(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
