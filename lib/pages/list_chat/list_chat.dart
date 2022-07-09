import 'package:appchat/models/chat_user.dart';
import 'package:appchat/models/user.dart';
import 'package:appchat/pages/chat/chat_view.dart';
import 'package:appchat/services/constant.dart';
import 'package:appchat/services/http/cmd.dart';
import 'package:appchat/services/socket/socket.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../services/http/getx_http.dart';

class ListChatController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  final MySocketController _socket = Get.find();

  final User user = User();

  // List<ChatUserModel> listUserChat = [];

  late ChatUserModel myChatWith;
  int currentIndexChatUser = -1;

  RxList listData = [].obs;
  RxList listDataMatchQueue = [].obs;
  RxList listLikeYou = [].obs;

  @override
  onReady() {
    super.onReady();
    onLoadUserChat();
    onSocketInit();
  }

  onLoadUserChat() async {
    Map _body = {"username": user.userID};
    var _res = await _httpProvider.getListUserChat(_body);

    if (_res != null && _res.length > 0) {
      List _listLikeYou = [];
      List _listDataMatchQueue = [];
      List _listMatch = [];
      for (var i in _res) {
        ChatUserModel _obj = ChatUserModel().setData(i);

        int _now = DateTime.now().millisecondsSinceEpoch;
        _obj.process = ((_now - i['time']) / 86400000).clamp(0.0, 1.0);

        if (i['match'] == true) {
          if (i['time'] > (_now - 86400000) && i['last_message'] == null) {
            _listDataMatchQueue.add(_obj);
          } else {
            _listMatch.add(_obj);
          }
        } else {
          _listLikeYou.add(_obj);
        }
      }

      if (_listLikeYou.length == 1) {
        _listLikeYou.add(_listLikeYou[0]);
      }

      listLikeYou.value = _listLikeYou;
      listData.value = _listMatch;
      listDataMatchQueue.value = _listDataMatchQueue;
    }
  }

  onSocketInit() {
    _socket.receiveMessage.listen((data) {
      bool _notIn = true;
      for (ChatUserModel i in listData) {
        if (i.userName == data['sender_chat_id']) {
          // i.lastMessage.message = data['content'];
          // i.lastMessage.read = false;
          _notIn = false;
          break;
        }
      }
      if (_notIn) {
        ChatUserModel _obj = ChatUserModel();
        _obj.userID = data['sender_chat_id'];
        _obj.userName = data['sender_chat_name'];
        _obj.profileImage = data['sender_chat_avatar'];
        _obj.profileImageDecoration = DecorationImage(
            image: NetworkImage(baseUrl + data['sender_chat_avatar']));
        _obj.lastMessage.message = data['content'];
        _obj.lastMessage.youFirst = false;
        _obj.lastMessage.isFirst = true;
        _obj.lastMessage.read = false;
        _obj.chatType = ChatModelType.incomingExpire;

        listData.add(_obj);
      }
      update();
    });
  }

  onClickItem(item) {
    // currentIndexChatUser = index;
    myChatWith = item;

    // _socket.socket!.emit('read_message',
    //     {'username': user.username, 'chatWith': myChatWith!.userName});

    // if (!myChatWith!.read) {
    //   myChatWith!.read = true;
    //   update();
    // }

    Get.to(() => ChatsView());
  }

  updateLastMessage() {
    // listUserChat[currentIndexChatUser] = myChatWith;

    update();
  }
}
