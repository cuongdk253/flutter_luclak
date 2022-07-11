import 'package:appchat/pages/list_profile/list_profile_view.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../../services/http/getx_http.dart';
import '../detail_profile/detail_profile_view.dart';

class PersonalController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();

  final User user = User();

  @override
  onReady() async {
    super.onReady();

    loadUser();
  }

  loadUser() async {
    var _res = await _httpProvider.getUserInfo();
    if (_res != null) {
      User().setUserData(_res);
      update();
    }
  }

  onClickListProfile() {
    Get.to(() => ListProfileView());
  }

  onClickEditProfile() {
    Get.to(() => DetailProfileView(), arguments: '+84398498960_1655305278024');
  }
}
