import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'cmd.dart';

class MyHttpProvider extends GetConnect {
  Map<String, String> headerSignature = {};

  @override
  void onInit() async {
    headerSignature['Content-Type'] = 'application/json';
  }

  setToken(String token) {
    headerSignature['x-access-token'] = token;
  }

  Future<dynamic> doVerifyUser(Map _body) async {
    Response response = await post(
      baseUrl + verifyUser,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> doAutoLogin(Map _body) async {
    Response response = await post(
      baseUrl + autoLogin,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> getListUserChat(Map _body) async {
    Response response = await post(
      baseUrl + listUserChat,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> getListMessage(Map _body) async {
    Response response = await post(
      baseUrl + listMessage,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> getListLiked(Map _body) async {
    Response response = await post(
      baseUrl + listLiked,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> getFindMatch(Map _body) async {
    Response response = await post(
      baseUrl + listUserFind,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  //Xử lý response
  _handleResponse(Response response) async {
    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint(response.statusText);
      return null;
    }
  }
}
