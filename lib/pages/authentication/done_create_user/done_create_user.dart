import 'package:get/get.dart';

import '../step_create_profile/step_create_profile_view.dart';

class DoneCreateUserController extends GetxController {
  onClickNext() async {
    Get.to(() => StepCreateProfileView());
  }
}
