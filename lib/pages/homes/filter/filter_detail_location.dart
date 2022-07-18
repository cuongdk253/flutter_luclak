import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import 'filter.dart';

class FilterDetailView extends GetView<FilterController> {
  final FilterController c = Get.put(FilterController());

  FilterDetailView({Key? key}) : super(key: key);

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
        ],
      ),
    );
  }

  Widget mBody() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      width: Get.width,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 24),
                child: TextCustom(
                  'location_booking'.tr,
                  style: AppTheme.textStyle.copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                children: [
                  const SizedBox(width: 32),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: AppTheme.colorGreyText1,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      child: TextFormField(
                        style: AppTheme.textStyle18.medium().grey(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          border: InputBorder.none,
                          filled: true,
                          fillColor: AppTheme.colorGreyText1,
                          hintText: 'location_search'.tr,
                          hintStyle: const TextStyle(
                              fontSize: 16, color: Color(0xFFA1A1A1)),
                          // prefixIcon: const Align(
                          //   widthFactor: 1.0,
                          //   heightFactor: 1.0,
                          //   child: Icon(
                          //     Icons.person,
                          //   ),
                          // ),
                        ),

                        //onChanged: (value) => c.onChangeName(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
              const SizedBox(height: 10),
              for (var i = 0; i < c.tinhThanh.length; i++)
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Obx(() {
                              return Checkbox(
                                value: c.tinhThanhCheck[i].value,
                                checkColor: AppTheme.colorWhite,
                                onChanged: (_value) {
                                  c.tinhThanhCheck[i].value = _value!;
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
                          ),
                          TextCustom(
                            c.tinhThanh[i],
                            style: AppTheme.textStyle.copyWith(fontSize: 16),
                          ),
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
                  ],
                ),
            ],
          ),
          Positioned(
            bottom: 32,
            right: 32,
            left: 32,
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
              onTap: () => c.onClickBack(),
            ),
          )
        ],
      ),
    );
  }
}
