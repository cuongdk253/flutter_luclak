import 'package:appchat/services/http/cmd.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MySocketController extends GetxController {
  Socket? socket;

  final String userID;

  MySocketController(this.userID);

  RxMap receiveMessage = {}.obs;
  RxMap receiveLike = {}.obs;

  @override
  void onInit() async {
    super.onInit();

    socket = io(
      baseSocket,
      OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({'phone': userID})
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();

    socket!.on('receive_message', (data) {
      receiveMessage.value = data;
    });

    socket!.on('receive_like', (data) {
      receiveLike.value = data;
    });

    socket!.on('connect_error', (data) {
      debugPrint(data.toString());
    });
  }
}
