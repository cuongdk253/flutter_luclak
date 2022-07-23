import 'package:appchat/services/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/http/getx_http.dart';
import '../../../services/themes/app_theme.dart';
import '../done_create_user/done_create_user_view.dart';

class StepCreateUserController extends GetxController
    with GetTickerProviderStateMixin {
  final MyHttpProvider _httpProvider = Get.find();

  TextEditingController fullName = TextEditingController();

  RxDouble processStep = 0.25.obs;

  List listGender = [
    {'code': Gender.male, 'name': 'man'.tr, 'checked': false},
    {'code': Gender.female, 'name': 'women'.tr, 'checked': false},
    {'code': Gender.nonbinary, 'name': 'nonbinary'.tr, 'checked': false},
    {'code': Gender.private, 'name': 'private'.tr, 'checked': false},
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

  int idUpdateImage = 1;

  RxString birthDay = 'DD'.obs;
  RxString birthMonth = 'MM'.obs;
  RxString birthYear = 'YYYY'.obs;

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

  onClickNext() async {
    if (canNext.value) {
      if (step.value < 4) {
        canNext.value = false;

        _controller.forward();

        await Future.delayed(const Duration(milliseconds: 300));
        step.value += 1;
        processStep.value += 0.25;

        _controller.reset();
      } else {
        doUpdateUserAndNext();
      }
    }
  }

  onClickBirthday() async {
    DateTime _myBirth = DateTime(
      int.tryParse(birthYear.value) ?? 1995,
      int.tryParse(birthMonth.value) ?? 1,
      int.tryParse(birthDay.value) ?? 1,
    );
    await Get.bottomSheet(
      SizedBox(
        height: 220,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1, color: AppTheme.colorDisable),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: TextCustom(
                          'birth'.tr,
                          style: AppTheme.textStyle16.medium(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: InkWell(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextCustom(
                              'done'.tr,
                              style: AppTheme.textStyle16.medium().secondary(),
                            ),
                          ),
                          onTap: () => Get.back(),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    key: UniqueKey(),
                    onDateTimeChanged: (DateTime value) => _myBirth = value,
                    initialDateTime: _myBirth,
                    mode: CupertinoDatePickerMode.date,
                    maximumDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day, 23, 59, 59),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    birthDay.value = _myBirth.day > 9
        ? _myBirth.day.toString()
        : '0${_myBirth.day.toString()}';
    birthMonth.value = _myBirth.month > 9
        ? _myBirth.month.toString()
        : '0${_myBirth.month.toString()}';
    birthYear.value = _myBirth.year.toString();

    canNext.value = true;
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
    canNext.value = true;
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

    canNext.value = true;
  }

  onChangeName() {
    if (fullName.text != '') {
      canNext.value = true;
    }
  }

  doUpdateUserAndNext() async {
    Map _body = {
      "name": fullName.text,
      "birth": "${birthDay.value}-${birthMonth.value}-${birthYear.value}",
      "gender": genderCode.value,
      "type": userTypeCode.value
    };

    var _res = await _httpProvider.doUpdateUser(_body);
    if (_res != null) {
      Get.to(() => DoneCreateUserView());
    }
  }
}
