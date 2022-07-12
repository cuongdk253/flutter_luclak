import 'package:appchat/pages/personals/personal/personal.dart';
import 'package:get/get.dart';

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
