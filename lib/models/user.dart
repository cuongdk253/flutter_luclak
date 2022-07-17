import 'package:intl/intl.dart';

class User {
  String userID = '';
  String profileID = '';
  String fullName = '';
  String address = '';
  String email = '';
  String idCard = '';
  String birthday = '';
  int age = 28;
  String userType = '';
  String gender = '';
  String avatarUrl = '';

  List listImage = [];
  List listPower = [];
  String about = '';

  bool newLike = false;
  bool newChat = false;

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
    avatarUrl = data['avatar'] ?? '';

    if (data['birth'] != null) {
      String _date = data['birth'].replaceAll('-', '/');
      DateTime _birth = DateFormat('MM/dd/yyyy').parse(_date);
      int _time =
          DateTime.now().millisecondsSinceEpoch - _birth.millisecondsSinceEpoch;
      birthday = data['birth'];
      age = (_time / 31536000000).floor();
    }

    newLike = data['new_like'] ?? false;
    newChat = data['new_chat'] ?? false;

    listImage = data['images'] ?? [];
    listPower = data['powers'] ?? [];
    about = data['about'] ?? '';
  }
}
