import 'package:get/get.dart';

import '../../services/http/getx_http.dart';

class LikedYouController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();

  // final User _user = User();

  RxList listData = [].obs;

  RxBool loaded = false.obs;

  RxBool youLike = false.obs;

  @override
  onReady() async {
    super.onReady();

    onLoadData();
  }

  onLoadData() async {
    Map _body = {"me": youLike.value};
    var _res = await _httpProvider.getListLike(_body);
    if (_res != null) {
      listData.value = _res;
    }
  }

  onClickTab(bool _youLike) {
    youLike.value = _youLike;
    onLoadData();
  }

  onClickSeeWhoLikeYou() {}
}
