import 'package:appchat/models/user.dart';
import 'package:appchat/services/socket/socket.dart';
import 'package:get/get.dart';

import '../../services/http/getx_http.dart';

class FilterController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  //final MySocketController _socket = Get.find();

  final User user = User();

  @override
  onReady() {
    super.onReady();
  }

}
