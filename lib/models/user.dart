import 'package:appchat/services/http/cmd.dart';
import 'package:flutter/cupertino.dart';

class User {
  String username = '';
  String fullName = 'Lo A Pao';
  String address = '';
  String email = '';
  String idCard = '';
  // String status = '';
  String userType = '';
  String avatarUrl = '';
  ImageProvider? avatarProvider;

  static final User _instance = User.internal();

  User.internal();
  factory User() => _instance;

  setUserData(data) {
    username = data['id'] ?? '';
    fullName = data['name'] ?? '';
    address = data['address'] ?? '';
    email = data['email'] ?? '';
    idCard = data['id_number'] ?? '';
    // status = data['active'] ?? '';
    userType = data['type'] ?? '';
    if (data['avatar'] != null) {
      avatarUrl = data['avatar'];
      avatarProvider = NetworkImage(baseUrl + data['avatar']);
    }
  }
}
