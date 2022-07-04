import 'package:get/get.dart';

import '../../tab/tab_view.dart';

class DoneCreateProfileController extends GetxController {
  onClickNext() async {
    Get.offAll(() => MyTabView());
  }
}
