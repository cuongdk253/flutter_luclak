import 'package:get/get.dart';

class SettingController extends GetxController {
  // @override
  // onInit() async {
  //   super.onInit();

  // }

  List listSetting = [
    {'svg': 'assets/svgs/notification.svg', 'title': 'notification'.tr},
    {'svg': 'assets/svgs/setting2.svg', 'title': 'public'.tr},
  ];
  List listSetting1 = [
    {'svg': 'assets/svgs/info.svg', 'title': 'help'.tr},
    {'svg': 'assets/svgs/bag.svg', 'title': 'manage_package'.tr},
    {'svg': 'assets/svgs/chat2.svg', 'title': 'send_feedback'.tr},
    {'svg': 'assets/svgs/share.svg', 'title': 'share'.tr},
    {'svg': 'assets/svgs/star3.svg', 'title': 'rate_appstore'.tr},
  ];

  onClickBack() {
    Get.back();
  }
}
