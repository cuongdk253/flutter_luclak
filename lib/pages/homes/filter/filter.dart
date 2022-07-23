import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import 'filter_detail_location.dart';
import 'filter_detail_language.dart';

class FilterController extends GetxController {
  final User user = User();

  double minRangeAge = 1.0;
  double maxRangeAge = 100.0;
  Rx<RangeLabels> labels = const RangeLabels("1.0", "100.0").obs;
  RxString startLabelRangeAge = "1".obs;
  RxString endLabelRangeAge = "100".obs;
  Rx<RangeValues> values = const RangeValues(1.0, 100.0).obs;

  double minRangeBudget = 0.0;
  double maxRangeBudget = 10000.0;
  Rx<RangeLabels> labelsBudget = const RangeLabels("0.0", "10000.0").obs;
  RxString startLabelRangeBudget = "1".obs;
  RxString endLabelRangeBudget = "10000".obs;
  Rx<RangeValues> valuesBudget = const RangeValues(0.0, 10000.0).obs;

  RxBool checkToggle = false.obs;

  RxBool checkMan = false.obs;
  RxBool checkWoman = false.obs;
  RxBool checkOther = false.obs;

  List<String> tinhThanh = [
    "Ha Noi",
    "Da Nang",
    "Ho Chi Minh",
    "Can Tho",
    "Nha Trang",
    "Hai Phong",
    "Vinh"
  ];
  List<RxBool> tinhThanhCheck = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs
  ];

  List<String> arrLanguage = [
    "Vietnamese",
    "Thailand",
    "English",
    "France",
    "Chinese",
    "Korea",
    "Japanese"
  ];
  List<RxBool> arrLanguageCheck = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs
  ];

  @override
  void onInit() {
    super.onInit();
    onCreatePamrams();
  }

  // @override
  // onReady() {
  //   super.onReady();
  // }

  onCreatePamrams() {
    labels = RangeLabels(minRangeAge.toString(), maxRangeAge.toString()).obs;
    startLabelRangeAge = minRangeAge.toString().obs;
    endLabelRangeAge = maxRangeAge.toString().obs;
    values = RangeValues(minRangeAge, maxRangeAge).obs;

    labelsBudget =
        RangeLabels(minRangeBudget.toString(), maxRangeBudget.toString()).obs;
    startLabelRangeBudget = overNumGenerator(minRangeBudget.round()).obs;
    endLabelRangeBudget = overNumGenerator(maxRangeBudget.round()).obs;
    valuesBudget = RangeValues(minRangeBudget, maxRangeBudget).obs;
  }

  onClickBack() {
    Get.back();
  }

  onFilterViewLocation() {
    Get.to(() => FilterDetailView());
  }

  onFilterViewLanguage() {
    Get.to(() => FilterDetailLanguageView());
  }

  onChangeToggle() {
    checkToggle.value = !checkToggle.value;
  }

  String overNumGenerator(int num) {
    if (num > 9999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} k";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} m";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} b";
    } else {
      return num.toString();
    }
  }
}
