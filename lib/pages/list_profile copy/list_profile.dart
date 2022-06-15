import 'package:appchat/services/socket/socket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/http/getx_http.dart';
import '../list_chat/list_chat.dart';

class ListProfileController extends GetxController {
  final MyHttpProvider _httpProvider = Get.find();
  final MySocketController _socket = Get.find();

  final ListChatController listChatController = Get.find();

  RxList listChat = [].obs;

  ScrollController? scrollController;
  ScrollController? imageScrollCtrl;

  RxBool showImageGalleryBar = false.obs;
  RxBool showChatBar = false.obs;

  // @override
  // onInit() async {
  //   super.onInit();

  // }

  onSocketInit() {
    _socket.receiveMessage.listen((data) {
      debugPrint(data.toString());
      if (data['senderChatID'] == listChatController.myChatWith!.userName) {
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
      }
    });
  }

  onLoadMessage() async {
    Map _body = {
      "username": listChatController.user.username,
      "chatWith": listChatController.myChatWith!.userName,
    };
    var _res = await _httpProvider.getListMessage(_body);

    if (_res != null) {
      for (var i in _res) {
        bool _isFirst = true;
        if (listChat.isNotEmpty) {
          _isFirst = listChat.last['me'] != i['me'];
        }
        listChat.add({
          'me': i['me'],
          'content': i['content'],
          'time': i['item'],
          'is_first': _isFirst,
        });
      }
    }
    doScroll(firstScroll: true);
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
  doScroll({bool firstScroll = false}) async {
    if (scrollController!.hasClients) {
      await Future.delayed(const Duration(milliseconds: 100));

      scrollController!.animateTo(scrollController!.position.maxScrollExtent,
          duration: Duration(milliseconds: (firstScroll ? 200 : 100)),
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
      'content': text,
      'time': DateTime.now().millisecondsSinceEpoch,
      'show_avatar': false,
      'is_first': _isFirst,
    });

    doScroll();

    _socket.socket!.emit('send_message', {
      'receiverChatID': listChatController.myChatWith!.userName,
      'senderChatID': listChatController.user.username,
      'senderChatName': listChatController.user.fullName,
      'senderChatAvatar': listChatController.user.avatarUrl,
      'content': text,
    });

    listChatController.myChatWith!.content = text;
    listChatController.updateLastMessage();
  }

  onClickBack() {
    Get.back();
  }
}
