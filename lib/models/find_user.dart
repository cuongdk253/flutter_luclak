import 'package:flutter/material.dart';

import '../services/http/cmd.dart';

class FindUserModel {
  String id = '';
  String name = '';
  String about = '';
  String address = '';
  ImageProvider avatarProvider =
      const AssetImage('assets/imgs/cute-didongviet.jpg');
  List<ImageProvider> images = [];
  List<String> favorites = [];

  FindUserModel setData(data) {
    FindUserModel _obj = FindUserModel();
    if (data['_id'] != null) {
      _obj.id = data['_id'];
    }
    if (data['name'] != null) {
      _obj.name = data['name'];
    }
    if (data['about'] != null) {
      _obj.about = data['about'];
    }
    if (data['address'] != null) {
      _obj.address = data['address'];
    }
    if (data['avatar'] != null) {
      _obj.avatarProvider = NetworkImage(baseUrl + data['avatar']);
    }
    if (data['images'] != null && data['images'].length > 0) {
      // images = [];
      // for (String i in data['images']) {
      //   NetworkImage _obj = NetworkImage(baseUrl + data['avatar']);
      //   images.add(_obj);
      // }
    }
    if (data['favorites'] != null && data['favorites'].length > 0) {
      favorites = [];
      for (String i in data['images']) {
        favorites.add(i);
      }
    }
    return _obj;
  }
}
