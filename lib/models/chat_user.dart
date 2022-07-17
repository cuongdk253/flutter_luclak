import 'package:flutter/material.dart';

import '../services/constant.dart';
import '../services/http/cmd.dart';

class ChatUserModel {
  String id = '';
  int time = 0;

  String userID = '';
  String userName = '';

  String profileID = '';
  String profileImage = '';

  DecorationImage profileImageDecoration = const DecorationImage(
      image: AssetImage('assets/imgs/logo_app.png'), fit: BoxFit.cover);

  String userIDLiked = '';
  String userNameLiked = '';

  LastMessage lastMessage = LastMessage(
    message: '',
    youFirst: false,
    isFirst: true,
    read: false,
  );

  double process = 0.0;

  ChatModelType chatType = ChatModelType.expire;

  ChatUserModel setData(data) {
    ChatUserModel _obj = ChatUserModel();
    if (data['_id'] != null) {
      _obj.id = data['_id'];
    }
    if (data['time'] != null) {
      _obj.time = data['time'];
    }
    if (data['user_id'] != null) {
      _obj.userID = data['user_id'];
    }
    if (data['user_name'] != null) {
      _obj.userName = data['user_name'];
    }
    if (data['profile_id'] != null) {
      _obj.profileID = data['profile_id'];
    }
    if (data['user_id_liked'] != null) {
      _obj.userIDLiked = data['user_id_liked'];
    }
    if (data['user_name_liked'] != null) {
      _obj.userNameLiked = data['user_name_liked'];
    }

    if (data['profile_image'] != null) {
      _obj.profileImage = data['profile_image'];
      _obj.profileImageDecoration = DecorationImage(
        image: NetworkImage(baseUrl + data['profile_image']),
        fit: BoxFit.cover,
      );
    }

    if (data['last_message'] != null) {
      _obj.lastMessage = LastMessage(
        message: data['last_message']['message'] ?? '',
        youFirst: data['last_message']['you_first'] ?? false,
        isFirst: data['last_message']['is_first'] ?? true,
        read: data['last_message']['read'] ?? false,
      );

      if (_obj.lastMessage.isFirst) {
        if (_obj.lastMessage.youFirst) {
          _obj.chatType = ChatModelType.expireWithYourMove;
        } else {
          _obj.chatType = ChatModelType.incomingExpire;
        }
      } else {
        _obj.chatType = ChatModelType.normal;
      }
    }

    return _obj;
  }
}

class LastMessage {
  String message;
  bool youFirst;
  bool isFirst;
  bool read;

  LastMessage({
    required this.message,
    this.youFirst = false,
    this.isFirst = true,
    this.read = false,
  });
}
