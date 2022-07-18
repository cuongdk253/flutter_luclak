import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';

class FilterController extends GetxController {
  // final MyHttpProvider _httpProvider = Get.find();
  //final MySocketController _socket = Get.find();

  final User user = User();

  RangeValues currentRangeValues = const RangeValues(22, 30);

  // @override
  // onReady() {
  //   super.onReady();
  // }

}
