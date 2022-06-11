import 'package:flutter/material.dart';

import '../services/http/cmd.dart';

class ChatUserModel {
  String id = '';
  String userName = '';
  String name = '';
  String content = '';
  bool read = false;
  int time = 0;
  String avatar = 'assets/imgs/cute-didongviet.jpg';
  ImageProvider avatarProvider =
      const AssetImage('assets/imgs/cute-didongviet.jpg');

  ChatUserModel setData(data) {
    ChatUserModel _obj = ChatUserModel();
    if (data['_id'] != null) {
      _obj.userName = data['_id'];
    }
    if (data['name'] != null) {
      _obj.name = data['name'];
    }
    if (data['content'] != null) {
      _obj.content = data['content'];
    }
    if (data['read'] != null) {
      _obj.read = data['read'];
    }
    if (data['time'] != null) {
      _obj.time = data['time'];
    }
    if (data['avatar'] != null) {
      _obj.avatar = data['avatar'];
      _obj.avatarProvider = NetworkImage(baseUrl + data['avatar']);
    }
    return _obj;
  }
}
