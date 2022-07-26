import 'package:appchat/components/image_decoration.dart';
import 'package:get/get.dart';

import '../../../models/chat_user.dart';
import '../../../models/user.dart';
import '../../../services/constant.dart';
import '../../../services/http/getx_http.dart';
import '../../../services/socket/socket.dart';
import '../chat/chat_view.dart';

class ListChatController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  final MySocketController _socket = Get.find();

  final User user = User();

  late ChatUserModel myChatWith;
  int currentIndexChatUser = -1;

  RxList listData = [].obs;
  RxList listDataMatchQueue = [].obs;
  RxList listLikeYou = [].obs;

  RxBool loaded = false.obs;

  @override
  onReady() {
    super.onReady();
    onLoadUserChat();
    onSocketInit();
  }

  onLoadUserChat() async {
    var _res = await _httpProvider.getListUserChat({});

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

      // if (_listLikeYou.length == 1) {
      //   _listLikeYou.add(_listLikeYou[0]);
      // }

      listLikeYou.value = _listLikeYou;
      listData.value = _listMatch;
      listDataMatchQueue.value = _listDataMatchQueue;

      update();
    }

    loaded.value = true;
  }

  onSocketInit() {
    _socket.receiveMessage.listen((data) {
      bool _newChat = true;
      for (ChatUserModel i in listData) {
        if (i.userID == data['sender_chat_id']) {
          _newChat = false;

          i.lastMessage.message = data['content'];
          i.lastMessage.read = false;
          i.lastMessage.youFirst = false;

          break;
        }
      }

      if (_newChat) {
        listDataMatchQueue
            .removeWhere((e) => e.userID == data['sender_chat_id']);

        ChatUserModel _obj = ChatUserModel();
        _obj.userID = data['sender_chat_id'];
        _obj.userName = data['sender_chat_name'];
        _obj.profileImage = data['sender_chat_avatar'];
        _obj.profileImageDecoration =
            myImageDecoration(data['sender_chat_avatar']);

        LastMessage _lastMessage = LastMessage(message: data['content']);
        _obj.lastMessage = _lastMessage;

        _obj.chatType = ChatModelType.incomingExpire;

        listData.insert(0, _obj);
      }

      update();
    });
  }

  onClickItem(ChatUserModel item) {
    if (item.chatType != ChatModelType.expire) {
      myChatWith = item;

      _socket.socket.emit('read_message',
          {'user_id': user.userID, 'chat_with': myChatWith.userID});

      myChatWith.lastMessage.read = true;

      update();

      Get.to(() => ChatsView());
    }
  }
}
