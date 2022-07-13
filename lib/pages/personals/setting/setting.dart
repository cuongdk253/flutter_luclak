import 'package:appchat/pages/authentication/login/login_view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

import '../../../services/http/getx_http.dart';

class SettingController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();

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

  List listSetting2 = [
    {'svg': 'assets/svgs/logout.svg', 'title': 'logout'.tr},
  ];

  onClickBack() {
    Get.back();
  }

  onClickLogout() {
    AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'logout'.tr,
        desc: 'ask_logout'.tr,
        btnOkText: 'yes'.tr,
        btnCancelText: 'no'.tr,
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await _httpProvider.doLogout();
          Get.offAll(() => LoginView());
        }).show();
  }
}
