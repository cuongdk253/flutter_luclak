import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/http/getx_http.dart';
import '../../../services/socket/socket.dart';
import '../list_chat/list_chat.dart';

class ChatsController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  final MySocketController _socket = Get.find();

  final ListChatController listChatController = Get.find();

  RxList listChat = [].obs;

  ScrollController? scrollController;
  ScrollController? imageScrollCtrl;

  RxBool showImageGalleryBar = false.obs;
  RxBool showChatBar = false.obs;

  RxString avatarUrl = ''.obs;
  RxString chatName = ''.obs;

  @override
  onInit() async {
    super.onInit();

    onSocketInit();

    onLoadMessage();

    scrollController = ScrollController();
    imageScrollCtrl = ScrollController();
  }

  onSocketInit() {
    _socket.receiveMessage.listen((data) {
      if (data['sender_chat_id'] == listChatController.myChatWith.userID) {
        bool _isFirst = true;
        if (listChat.isNotEmpty && listChat.last['me'] == false) {
          _isFirst = false;
        }
        listChat.add({
          'me': false,
          'content': data['content'],
          'time': DateTime.now().millisecondsSinceEpoch,
          'is_first': _isFirst,
        });

        doScroll();

        _socket.socket!.emit('read_message', {
          'user_id': listChatController.user.userID,
          'chat_with': listChatController.myChatWith.userID
        });
        listChatController.myChatWith.lastMessage.read = true;
        listChatController.update();
      }
    });
  }

  onLoadMessage() async {
    chatName.value = listChatController.myChatWith.userName;
    avatarUrl.value = listChatController.myChatWith.profileImage;

    Map _body = {
      "chat_with": listChatController.myChatWith.userID,
      "page": 0,
      "item_per_page": 20,
    };
    var _res = await _httpProvider.getListMessage(_body);

    if (_res != null) {
      for (var i in _res) {
        bool _isFirst = true;
        if (listChat.isNotEmpty) {
          _isFirst = listChat.last['user_id'] != i['user_id'];
        }

        listChat.add({
          'me': i['user_id'] == listChatController.user.userID,
          'user_id': i['user_id'],
          'content': i['content'],
          'time': i['time'],
          'is_first': _isFirst,
        });
      }

      listChat.sort((a, b) => a['time'].compareTo(b['time']));
    }
    doScroll(scrollDuration: 300);
  }

  //Load thư viện ảnh
  onLoadGallery() async {
    // if (await Permission.storage.request().isGranted) {
    //   List<Album> _albums =
    //       await PhotoGallery.listAlbums(mediumType: MediumType.image);
    //   Album _album = _albums.firstWhere((element) => element.id == '__ALL__');
    //   MediaPage _mediaPage = await _album.listMedia();
    //   media = _mediaPage.items;
    //   mediaShow = media.take(12).toList();
    // }
  }

  //Animation cuộn xuống dưới cùng
  doScroll({int scrollDuration = 100}) async {
    if (scrollController!.hasClients) {
      await Future.delayed(Duration(milliseconds: scrollDuration));

      scrollController!.animateTo(scrollController!.position.maxScrollExtent,
          duration: Duration(milliseconds: scrollDuration),
          curve: Curves.easeOut);
    }
  }

  //Click vào item album ảnh
  onClickGalleryItem(index) {
    // if (listIndexGallery.contains(index))
    //   listIndexGallery.removeWhere((element) => element == index);
    // else
    //   listIndexGallery.add(index);
    // update();
  }

  onClickChatSend(String text) async {
    bool _isFirst = true;

    if (listChat.isNotEmpty) {
      if (listChat.last['me'] == true) {
        _isFirst = false;
      }
    }

    listChat.add({
      'me': true,
      'user_id': listChatController.user.userID,
      'content': text,
      'time': DateTime.now().millisecondsSinceEpoch,
      'is_first': _isFirst,
    });

    doScroll();

    _socket.socket!.emit('send_message', {
      'receiver_chat_id': listChatController.myChatWith.userID,
      'sender_chat_id': listChatController.user.userID,
      'sender_chat_name': listChatController.user.fullName,
      'sender_chat_avatar': listChatController.user.avatarUrl,
      'content': text,
    });

    if (listChatController.myChatWith.lastMessage.isFirst) {
      await Future.delayed(const Duration(milliseconds: 500));
      listChatController.onLoadUserChat();
    } else {
      listChatController.myChatWith.lastMessage.message = text;
      listChatController.update();
    }
  }

  onClickBack() {
    Get.back();
  }
}
