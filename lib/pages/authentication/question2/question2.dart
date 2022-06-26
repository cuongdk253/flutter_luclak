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

class Question2Controller extends GetxController {
  final MyHttpProvider httpProvider = Get.find();

  TextEditingController phone = TextEditingController();
  TextEditingController countrySearch = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String? verificationId;

  List listPhoneCode = [];
  RxList listPhoneCodeShow = [].obs;

  RxString countryCode = 'VN'.obs;
  RxString phoneCode = '+84'.obs;

  String username = '';
  String fcmToken = '';

  RxDouble minPudget = 0.0.obs;
  RxDouble maxPudget = 80.0.obs;

  @override
  onInit() async {
    super.onInit();

    loadData();
    loadPhoneCode();
  }

  loadData() async {
    fcmToken = (await FirebaseMessaging.instance.getToken())!;
  }

  loadPhoneCode() async {
    String _phoneCode =
        await rootBundle.loadString('assets/jsons/phone_code.json');

    if (_phoneCode.isNotEmpty) {
      listPhoneCodeShow.value = listPhoneCode = jsonDecode(_phoneCode);
    }
  }

  onClickNext() async {
    username = phoneCode.value + phone.text;
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: username,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (verificationFailed) async {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.WARNING,
          animType: AnimType.BOTTOMSLIDE,
          title: 'send_otp_fail'.tr,
          autoHide: const Duration(seconds: 2),
          desc: 'send_otp_fail_des'.tr,
        ).show();
      },
      codeSent: (_verificationId, resendingToken) async {
        verificationId = _verificationId;
        Get.to(() => OtpView());
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        debugPrint(verificationId);
      },
    );
  }

  onListPhoneCodeChange() {
    String _keyword = countrySearch.text.toLowerCase();
    listPhoneCodeShow.value = listPhoneCode
        .where(
          (item) =>
              TiengViet.parse(item['name']).toLowerCase().contains(_keyword) ||
              item['country_code'].toLowerCase().contains(_keyword) ||
              item['phone_code'].contains(_keyword),
        )
        .toList();
  }

  onClickPhoneCode() {
    countrySearch.text = '';
    onListPhoneCodeChange();

    Get.bottomSheet(
      SafeArea(
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(Get.context!).padding.top + 16),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Container(
              color: AppTheme.colorWhite,
              child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration:
                        BoxDecoration(border: AppTheme.borderBottomLine),
                    child: Row(children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: countrySearch,
                            style: AppTheme.textStyle,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.colorBorder),
                                  borderRadius: BorderRadius.circular(16)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.colorBorder),
                                  borderRadius: BorderRadius.circular(16)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppTheme.colorBorder),
                                  borderRadius: BorderRadius.circular(16)),
                              hintText: 'search_location'.tr,
                              filled: true,
                              fillColor: AppTheme.colorBackground,
                            ),
                            onChanged: (value) => onListPhoneCodeChange(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton(
                          onPressed: () => Get.back(),
                          child: TextCustom(
                            'Cancel',
                            style: AppTheme.textStyle16.medium(),
                          ))
                    ]),
                  ),
                  Expanded(
                    child: Obx(() => ListView(
                          children: List.generate(
                            listPhoneCodeShow.length,
                            (index) => InkWell(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                decoration: BoxDecoration(
                                    border: AppTheme.borderBottomLine),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextCustom(
                                      listPhoneCodeShow[index]['name'],
                                      style: AppTheme.textStyle16.medium(),
                                    ),
                                    TextCustom(
                                      listPhoneCodeShow[index]['phone_code'],
                                      style: AppTheme.textStyle16.medium(),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Get.back();
                                var _obj = listPhoneCodeShow[index];
                                if (_obj != null) {
                                  countryCode.value = _obj['country_code'];
                                  phoneCode.value = _obj['phone_code'];
                                }
                              },
                            ),
                          ),
                        )),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  doLogin(String accessToken) {
    httpProvider.setToken(accessToken);
    Get.put(MySocketController(phoneCode.value + phone.text));
    Get.to(() => MyTabView());
  }
}
