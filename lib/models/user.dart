import 'dart:io';

import 'package:flutter/cupertino.dart';

class User {
  String username = '';
  String password = '';
  String phone = '0398498960';
  String fullName = 'Lo A Pao';
  String address = '';
  String email = '';
  String idCard = '';
  String status = '';
  String userType = '';
  String avatar = 'images/7afd515e62f13bf4d3dda140ef08cff7.jpg';
  late ImageProvider avatarUrl;

  static final User _instance = User.internal();

  User.internal();
  factory User() => _instance;

  void setUserData(data) {
    username = data['userName'] ?? '';
    password = data['passWord'] ?? '';
    phone = data['phoneNumber'] ?? '';
    fullName = data['fullName'] ?? '';
    address = data['address'] ?? '';
    email = data['email'] ?? '';
    idCard = data['idNumber'] ?? '';
    status = data['status'] ?? '';
    userType = data['userType'] ?? '';
  }

  void setAvatarUrl(String path) {
    avatarUrl = FileImage(File(path));
  }
}
