import 'package:appchat/pages/detail_profile/detail_profile_view.dart';
import 'package:get/get.dart';

import '../../models/user.dart';

// import '../../services/http/getx_http.dart';

class ListProfileController extends GetxController {
  // final MyHttpProvider _httpProvider = Get.find();

  // @override
  // onInit() async {
  //   super.onInit();

  // }

  final User user = User();

  onClickBack() {
    Get.back();
  }

  onClickAddProfile() {
    // Get.to(() => DetailProfileView(), arguments: '+84398498960');
    Get.to(() => DetailProfileView(), arguments: '+84398498960_1655305278024');
  }
}
