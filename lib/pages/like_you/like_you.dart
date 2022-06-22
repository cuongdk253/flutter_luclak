import 'package:get/get.dart';

import '../../models/user.dart';
import '../../services/http/getx_http.dart';

class LikedYouController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();

  final User _user = User();

  RxList listData = [].obs;

  RxBool loaded = false.obs;

  @override
  onReady() async {
    super.onReady();

    onLoadData();
  }

  onLoadData() async {
    Map _body = {"username": _user.username};
    var _res = await _httpProvider.getListLiked(_body);
    if (_res != null) {
      listData.value = _res;
    }
  }
}
