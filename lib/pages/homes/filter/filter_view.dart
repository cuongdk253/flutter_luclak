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
          InkWell(
            child: SvgPicture.asset(
              'assets/svgs/search.svg',
              color: AppTheme.colorText,
            ),
          )
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 10),
              child: TextCustom(
                'who_wanna_book'.tr,
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF343434),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: Colors.grey,
                      ),
                    )),
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          TextCustom(
                            'ok_with_everyone'.tr,
                            style: AppTheme.textStyle.copyWith(fontSize: 16),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                            ),
                          ),
                          InkWell(
                            child: MyToggle(
                              isOn: c.checkToggle.value,
                            ),
                            onTap: c.onChangeToggle(),
                          ), 
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 5),
                    child: Row(
                      children: [
                        TextCustom(
                          'man'.tr,
                          style: AppTheme.textStyle.copyWith(fontSize: 16),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Obx(() {
                            return Checkbox(
                              value: c.checkMan.value,
                              checkColor: AppTheme.colorWhite,
                              onChanged: (_value) {
                                c.checkMan.value = _value!;
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    width: 1.0, color: Colors.blue),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 5),
                    child: Row(
                      children: [
                        TextCustom(
                          'women'.tr,
                          style: AppTheme.textStyle.copyWith(fontSize: 16),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Obx(() {
                            return Checkbox(
                              value: c.checkWoman.value,
                              checkColor: AppTheme.colorWhite,
                              onChanged: (_value) {
                                c.checkWoman.value = _value!;
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    width: 1.0, color: Colors.blue),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Divider(
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 5),
                    child: Row(
                      children: [
                        TextCustom(
                          'non_binary_pp'.tr,
                          style: AppTheme.textStyle.copyWith(fontSize: 16),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Obx(() {
                            return Checkbox(
                              value: c.checkOther.value,
                              checkColor: AppTheme.colorWhite,
                              onChanged: (_value) {
                                c.checkOther.value = _value!;
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    width: 1.0, color: Colors.blue),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 10),
              child: TextCustom(
                'age'.tr,
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF343434),
              ),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: TextCustom(
                        'between'.tr +
                            ' ' +
                            double.parse(c.startLabelRangeAge.value)
                                .round()
                                .toString() +
                            ' ' +
                            'and'.tr +
                            ' ' +
                            double.parse(c.endLabelRangeAge.value)
                                .round()
                                .toString(),
                        style: AppTheme.textStyle.copyWith(fontSize: 16),
                      ),
                    ),
                    RangeSlider(
                      divisions: 99,
                      activeColor: Colors.blue[700],
                      inactiveColor: Colors.blue[300],
                      min: c.minRangeAge,
                      max: c.maxRangeAge,
                      values: c.values.value,
                      labels: RangeLabels(
                          double.parse(c.startLabelRangeAge.value)
                              .round()
                              .toString(),
                          double.parse(c.endLabelRangeAge.value)
                              .round()
                              .toString()),
                      onChanged: (value) {
                        c.values.value = value;
                        c.startLabelRangeAge.value = value.start.toString();
                        c.endLabelRangeAge.value = value.end.toString();
                      },
                    )
                  ],
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 10),
              child: TextCustom(
                'your_budget'.tr,
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF343434),
              ),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xFF808080),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: " \$" + c.startLabelRangeBudget.value,
                                    style: const TextStyle(
                                        color: Color(0xFF808080))),
                                const WidgetSpan(
                                  child: Icon(Icons.arrow_drop_down,
                                      size: 14, color: Color(0xFF808080)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: double.infinity,
                            height: 1,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xFF808080),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: " \$" + c.endLabelRangeBudget.value,
                                    style: const TextStyle(
                                        color: Color(0xFF808080))),
                                const WidgetSpan(
                                  child: Icon(Icons.arrow_drop_down,
                                      size: 14, color: Color(0xFF808080)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    RangeSlider(
                      divisions: 10000,
                      activeColor: Colors.blue[700],
                      inactiveColor: Colors.blue[300],
                      min: c.minRangeBudget,
                      max: c.maxRangeBudget,
                      values: c.valuesBudget.value,
                      labels: RangeLabels(c.startLabelRangeBudget.value,
                          c.endLabelRangeBudget.value),
                      onChanged: (value) {
                        c.valuesBudget.value = value;
                        c.startLabelRangeBudget.value =
                            c.overNumGenerator(value.start.round());
                        c.endLabelRangeBudget.value = c.overNumGenerator(
                            int.parse(value.end.round().toString()));
                      },
                    ),
                  ],
                );
              }),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 10),
              child: TextCustom(
                'location'.tr,
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF343434),
              ),
              child: InkWell(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: TextCustom(
                        'select_location'.tr,
                        style: AppTheme.textStyle.copyWith(fontSize: 16),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: SvgPicture.asset(
                          'assets/svgs/next.svg',
                          color: AppTheme.colorGreyText,
                          alignment: Alignment.centerRight,
                          width: 24,
                          height: 24,
                        )),
                  ],
                ),
                onTap: () => c.onFilterViewLocation(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 10),
              child: TextCustom(
                'language'.tr,
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF343434),
              ),
              child: InkWell(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: TextCustom(
                        'select_language'.tr,
                        style: AppTheme.textStyle.copyWith(fontSize: 16),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: double.infinity,
                        height: 1,
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: SvgPicture.asset(
                          'assets/svgs/next.svg',
                          color: AppTheme.colorGreyText,
                          alignment: Alignment.centerRight,
                          width: 24,
                          height: 24,
                        )),
                  ],
                ),
                onTap: () => c.onFilterViewLanguage(),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 10),
              child: TextCustom(
                'filters'.tr,
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF343434),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: TextCustom(
                      'adv_filters'.tr,
                      style: AppTheme.textStyle.copyWith(fontSize: 16),
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: double.infinity,
                      height: 1,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: SvgPicture.asset(
                        'assets/svgs/next.svg',
                        color: AppTheme.colorGreyText,
                        alignment: Alignment.centerRight,
                        width: 24,
                        height: 24,
                      )),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
