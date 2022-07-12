import 'package:appchat/models/user.dart';
import 'package:appchat/pages/personals/safe/safe_view.dart';
import 'package:appchat/pages/personals/setting/setting_view.dart';
import 'package:get/get.dart';

import '../detail_profile/detail_profile_view.dart';

class PersonalController extends GetxController {
  User user = User();

  @override
  onReady() async {
    super.onReady();

    update();
  }

  onClickSetting() {
    Get.to(() => SettingView());
  }

  onClickSafe() {
    Get.to(() => SafeView());
  }

  onClickEditProfile() {
    Get.to(() => DetailProfileView(), arguments: '+84398498960_1655305278024');
  }
}
