import 'package:appchat/services/http/cmd.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class MySocketController extends GetxController {
  Socket? socket;

  final String userID;

  MySocketController(this.userID);

  RxMap receiveMessage = {}.obs;

  @override
  void onInit() async {
    super.onInit();

    socket = io(
      baseUrl,
      // 'http://103.179.184.110:3000',
      // 'http://luclak.com/api/v1',
      OptionBuilder()
          // .setPath('/api/v1/socket.io')
          .setTransports(['websocket'])
          .setExtraHeaders({'phone': userID})
          .disableAutoConnect()
          .build(),
    );

    socket!.connect();

    socket!.on('receive_message', (data) {
      receiveMessage.value = data;
    });

    socket!.on('connect_error', (data) {
      debugPrint(data.toString());
    });
  }
}
