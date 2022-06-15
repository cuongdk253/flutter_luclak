import 'package:get/get.dart';

import '../../models/user.dart';
import '../../services/http/getx_http.dart';

class MatchesController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();

  final User _user = User();

  List listMatch = [];

  RxMap currentMatch = {}.obs;

  RxMap nextMatch = {}.obs;

  var _nextMatch = {};

  int nextIndex = 1;

  RxBool loaded = false.obs;

  @override
  onReady() async {
    super.onReady();

    onFindMatch();
  }

  onFindMatch() async {
    Map _body = {"username": _user.username};
    var _res = await _httpProvider.getFindMatch(_body);
    if (_res != null) {
      listMatch = [];
      for (var i in _res) {
        // FindUserModel _obj = FindUserModel().setData(i);
        listMatch.add(i);
      }

      loaded.value = true;

      if (listMatch.length > 1) {
        currentMatch.value = listMatch[0];
        _nextMatch = nextMatch.value = listMatch[1];
      } else if (listMatch.length == 1) {
        currentMatch.value = listMatch[0];
      }
    }
  }

  handleDrag(double dx) {
    if (dx.abs() > Get.width / 2) {
      currentMatch.value = _nextMatch;
      nextIndex += 1;
      if (nextIndex < listMatch.length) {
        _nextMatch = listMatch[nextIndex];
        nextMatch.value = _nextMatch;
      } else {
        _nextMatch = {};
        nextMatch.value = {};
      }
    }
  }

  onClickAccept() {
    handleDrag(Get.width);
  }

  onClickDecline() {
    handleDrag(Get.width);
  }
}
