import 'package:appchat/pages/chats/list_chat/list_chat.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../../services/http/getx_http.dart';
import '../../services/socket/socket.dart';

class MyTabController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  final MySocketController _socket = Get.find();

  final myTab = [
    {
      'icon': 'assets/svgs/search_tab.svg',
      'icon_active': 'assets/svgs/search_tab_active.svg'
    },
    {'icon': 'assets/svgs/heart.svg'},
    {'icon': 'assets/svgs/chat.svg'},
    {'icon': 'assets/svgs/user.svg'},
  ];

  RxInt tabIndex = 0.obs;

  RxBool dotLikeYou = false.obs;
  RxBool dotChat = false.obs;

  List listImageCache = [];

  @override
  void onReady() async {
    super.onReady();

    await loadUser();

    onSocketInit();

    dotLikeYou.value = User().newLike;
    dotChat.value = User().newChat;
  }

  loadUser() async {
    var _res = await _httpProvider.getUserInfo();
    if (_res != null) {
      User().setUserData(_res);
    }
  }

  onSocketInit() {
    _socket.receiveMessage.listen((data) {
      dotChat.value = true;
    });

    _socket.receiveLike.listen((data) async {
      dotLikeYou.value = true;

      if (data['match'] == true) {
        AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.SUCCES,
          animType: AnimType.SCALE,
          title: 'you_got_match'.tr,
          autoHide: const Duration(seconds: 10),
          desc: 'des_you_got_match'.tr,
        ).show();

        _socket.socket.emit('send_match', data);

        if (Get.isRegistered<ListChatController>()) {
          final ListChatController _ctrl = Get.find();

          await Future.delayed(const Duration(milliseconds: 500));
          _ctrl.onLoadUserChat();
        }
      }
    });
  }

  onClickTab(int index) {
    tabIndex.value = index;

    if (index == 1 || index == 2) {
      Map _body = {};
      if (index == 1) {
        _body['view_like'] = true;
        dotLikeYou.value = false;
      } else {
        _body['view_chat'] = true;
        dotChat.value = false;
      }
      _httpProvider.doViewAllNotification(_body);
    }
  }
}
