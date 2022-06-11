import 'package:appchat/models/chat_user.dart';
import 'package:appchat/models/user.dart';
import 'package:appchat/pages/chat/chat_view.dart';
import 'package:appchat/services/http/cmd.dart';
import 'package:appchat/services/socket/socket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/http/getx_http.dart';

class ListChatController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  final MySocketController _socket = Get.find();

  final User user = User();

  List<ChatUserModel> listUserChat = [];

  ChatUserModel? myChatWith;
  int currentIndexChatUser = -1;

  @override
  onReady() {
    super.onReady();
    onLoadUserChat();
    onSocketInit();
  }

  onLoadUserChat() async {
    Map _body = {"phone": user.phone};
    var _res = await _httpProvider.getListUserChat(_body);
    if (_res != null) {
      for (var i in _res) {
        ChatUserModel _obj = ChatUserModel().setData(i);
        listUserChat.add(_obj);
      }
    }
    update();
  }

  onSocketInit() {
    _socket.receiveMessage.listen((data) {
      bool _notIn = true;
      for (ChatUserModel i in listUserChat) {
        if (i.userName == data['senderChatID']) {
          i.content = data['content'];
          i.read = false;
          _notIn = false;
          break;
        }
      }
      if (_notIn) {
        ChatUserModel _obj = ChatUserModel();
        _obj.userName = data['senderChatID'];
        _obj.name = data['senderChatName'];
        _obj.avatar = data['senderChatAvatar'];
        _obj.avatarProvider = NetworkImage(baseUrl + data['senderChatAvatar']);
        _obj.content = data['content'];

        listUserChat.add(_obj);
      }
      update();
    });
  }

  onClickItem(index) {
    currentIndexChatUser = index;
    myChatWith = listUserChat[index];

    _socket.socket!.emit('read_message',
        {'phone': user.phone, 'chatWith': myChatWith!.userName});

    if (!myChatWith!.read) {
      myChatWith!.read = true;
      update();
    }

    Get.to(() => ChatsView());
  }

  updateLastMessage() {
    listUserChat[currentIndexChatUser] = myChatWith!;
    update();
  }
}
