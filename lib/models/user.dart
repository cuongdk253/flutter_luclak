import 'package:appchat/services/http/cmd.dart';
import 'package:flutter/cupertino.dart';

class User {
  String userID = '';
  String profileID = '';
  String fullName = '';
  String address = '';
  String email = '';
  String idCard = '';
  String userType = '';
  String gender = '';
  String avatarUrl = '';
  ImageProvider? avatarProvider;

  static final User _instance = User.internal();

  User.internal();
  factory User() => _instance;

  setUserData(data) {
    userID = data['_id'] ?? '';
    profileID = data['profile_id'] ?? '';
    fullName = data['name'] ?? '';
    address = data['address'] ?? '';
    email = data['email'] ?? '';
    idCard = data['id_number'] ?? '';
    userType = data['type'] ?? '';
    userType = data['gender'] ?? '';
    if (data['avatar'] != null) {
      avatarUrl = data['avatar'];
      avatarProvider = NetworkImage(baseUrl + data['avatar']);
    }
  }
}
