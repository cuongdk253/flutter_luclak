import 'dart:convert';

import 'package:appchat/components/text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../services/http/getx_http.dart';
import '../../../services/socket/socket.dart';
import '../../../services/themes/app_theme.dart';
import '../../tab/tab_view.dart';
import '../otp/otp_view.dart';

class StepCreateUserController extends GetxController
    with GetTickerProviderStateMixin {
  final MyHttpProvider httpProvider = Get.find();

  TextEditingController fullName = TextEditingController();

  RxDouble processStep = 0.2.obs;

  List listGender = [
    {'code': 'male', 'name': 'man'.tr, 'checked': false},
    {'code': 'female', 'name': 'women'.tr, 'checked': false},
    {'code': 'nonbinary', 'name': 'nonbinary'.tr, 'checked': false},
    {'code': 'private', 'name': 'private'.tr, 'checked': false},
  ];

  List listUserType = [
    {
      'code': 'client',
      'name': 'client'.tr,
      'description': 'des_client'.tr,
      'checked': false
    },
    {
      'code': 'creator',
      'name': 'creator'.tr,
      'description': 'des_creator'.tr,
      'checked': false
    },
  ];

  RxString genderCode = ''.obs;
  RxString userTypeCode = ''.obs;

  RxInt step = 1.obs;

  RxBool canNext = false.obs;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  @override
  onInit() async {
    super.onInit();

    loadData();
  }

  loadData() async {}

  onClickNext() async {
    if (canNext.value) {
      canNext.value = false;

      _controller.forward();

      await Future.delayed(const Duration(milliseconds: 300));
      step.value += 1;
      processStep.value += 0.2;

      _controller.reset();
    }
  }

  onClickPhoneCode() {
    // Get.bottomSheet(
    //   SafeArea(
    //     child: Container(
    //       margin: EdgeInsets.only(
    //           top: MediaQuery.of(Get.context!).padding.top + 16),
    //       child: ClipRRect(
    //         borderRadius: const BorderRadius.only(
    //           topLeft: Radius.circular(12),
    //           topRight: Radius.circular(12),
    //         ),
    //         child: Container(
    //           color: AppTheme.colorWhite,
    //           child: SizedBox(
    //             height: Get.height,
    //             width: Get.width,
    //             child: Column(children: [
    //               Container(
    //                 padding: const EdgeInsets.all(16),
    //                 decoration:
    //                     BoxDecoration(border: AppTheme.borderBottomLine),
    //                 child: Row(children: [
    //                   Expanded(
    //                     child: SizedBox(
    //                       height: 40,
    //                       child: TextFormField(
    //                         controller: countrySearch,
    //                         style: AppTheme.textStyle,
    //                         decoration: InputDecoration(
    //                           contentPadding: const EdgeInsets.symmetric(
    //                               vertical: 12, horizontal: 16),
    //                           isDense: true,
    //                           border: OutlineInputBorder(
    //                               borderSide:
    //                                   BorderSide(color: AppTheme.colorBorder),
    //                               borderRadius: BorderRadius.circular(16)),
    //                           enabledBorder: OutlineInputBorder(
    //                               borderSide:
    //                                   BorderSide(color: AppTheme.colorBorder),
    //                               borderRadius: BorderRadius.circular(16)),
    //                           focusedBorder: OutlineInputBorder(
    //                               borderSide:
    //                                   BorderSide(color: AppTheme.colorBorder),
    //                               borderRadius: BorderRadius.circular(16)),
    //                           hintText: 'search_location'.tr,
    //                           filled: true,
    //                           fillColor: AppTheme.colorBackground,
    //                         ),
    //                         onChanged: (value) => onListPhoneCodeChange(),
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(width: 16),
    //                   TextButton(
    //                       onPressed: () => Get.back(),
    //                       child: TextCustom(
    //                         'Cancel',
    //                         style: AppTheme.textStyle16.medium(),
    //                       ))
    //                 ]),
    //               ),
    //               Expanded(
    //                 child: Obx(() => ListView(
    //                       children: List.generate(
    //                         listPhoneCodeShow.length,
    //                         (index) => InkWell(
    //                           child: Container(
    //                             padding: const EdgeInsets.symmetric(
    //                                 vertical: 12, horizontal: 16),
    //                             decoration: BoxDecoration(
    //                                 border: AppTheme.borderBottomLine),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 TextCustom(
    //                                   listPhoneCodeShow[index]['name'],
    //                                   style: AppTheme.textStyle16.medium(),
    //                                 ),
    //                                 TextCustom(
    //                                   listPhoneCodeShow[index]['phone_code'],
    //                                   style: AppTheme.textStyle16.medium(),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                           onTap: () {
    //                             Get.back();
    //                             var _obj = listPhoneCodeShow[index];
    //                             if (_obj != null) {
    //                               countryCode.value = _obj['country_code'];
    //                               phoneCode.value = _obj['phone_code'];
    //                             }
    //                           },
    //                         ),
    //                       ),
    //                     )),
    //               )
    //             ]),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    //   isScrollControlled: true,
    // );
  }

  onClickGender(String _genderCode) {
    genderCode.value = _genderCode;
    for (var i in listGender) {
      if (i['code'] == genderCode.value) {
        i['checked'] = true;
      } else {
        i['checked'] = false;
      }
    }
  }

  onClickUserType(String _userTypeCode) {
    userTypeCode.value = _userTypeCode;
    for (var i in listUserType) {
      if (i['code'] == userTypeCode.value) {
        i['checked'] = true;
      } else {
        i['checked'] = false;
      }
    }
  }

  onChangeName() {
    if (fullName.text != '') {
      canNext.value = true;
    }
  }
}
