import 'package:get/get.dart';

import '../personal/personal.dart';

class SafeController extends GetxController {
  final PersonalController personalController = Get.find();

  @override
  onInit() async {
    super.onInit();

    update();
  }

  onClickBack() {
    Get.back();
  }
}
