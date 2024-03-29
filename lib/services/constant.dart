import 'package:get/get.dart';

//**Storage Key for share preferent */
class StorageKey {
  static const phoneNumber = 'phone_number';
  static const matchFilter = 'match_filter';
}

enum UserRole { kol, creator }

enum ChatModelType { normal, expire, incomingExpire, expireWithYourMove }

class ListConstant {
  final List listPower = [
    {'name': 'photograp'.tr, 'checked': false},
    {'name': 'edit_video'.tr, 'checked': false},
    {'name': 'review_sp'.tr, 'checked': false},
    {'name': 'crafts'.tr, 'checked': false},
    {'name': 'singing'.tr, 'checked': false},
    {'name': 'art'.tr, 'checked': false},
    {'name': 'writing'.tr, 'checked': false},
    {'name': 'stream'.tr, 'checked': false},
    {'name': 'design'.tr, 'checked': false},
  ];
}

class Gender {
  static const male = 'male';
  static const female = 'female';
  static const nonbinary = 'nonbinary';
  static const private = 'private';
}
