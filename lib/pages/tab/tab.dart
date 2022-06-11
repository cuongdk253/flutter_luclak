// import 'package:appchat/services/http/getx_http.dart';
import 'package:get/get.dart';

class MyTabController extends GetxController {
  // final MyHttpProvider _httpProvider = Get.find();

  final myTab = [
    {'icon': 'assets/svgs/swipe.svg'},
    {'icon': 'assets/svgs/history.svg'},
    {'icon': 'assets/svgs/chat.svg'},
    {'icon': 'assets/svgs/user.svg'},
  ];

  RxInt tabIndex = 0.obs;

  // @override
  // void onInit() {
  //   super.onInit();

  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  onClickTab(int index) {
    tabIndex.value = index;
  }
}
