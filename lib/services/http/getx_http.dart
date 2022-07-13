import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'cmd.dart';
import 'post_multipart.dart';

class MyHttpProvider extends GetConnect {
  Map<String, String> headerSignature = {};

  @override
  void onInit() async {
    headerSignature['Content-Type'] = 'application/json';
  }

  setToken(String token) {
    headerSignature['x-access-token'] = token;
    HttpPostMultipart().setToken(token);
  }

  Future<dynamic> doVerifyUser(Map _body) async {
    Response response = await post(
      baseUrl + verifyUser,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> doCreateUser(Map _body) async {
    Response response = await post(
      baseUrl + createUser,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> getUserInfo() async {
    Response response = await post(
      baseUrl + userInfo,
      {},
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

  Future<dynamic> doLogout() async {
    Response response = await post(
      baseUrl + logout,
      {},
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> doUpdateUser(Map _body) async {
    Response response = await post(
      baseUrl + updateUser,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> doCreateProfile(Map _body) async {
    Response response = await post(
      baseUrl + createProfile,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> doUpdateProfile(Map _body) async {
    Response response = await post(
      baseUrl + updateProfile,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> getDetailProfile(Map _body) async {
    Response response = await post(
      baseUrl + detailProfile,
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

  Future<dynamic> getListReview(Map _body) async {
    Response response = await post(
      baseUrl + listReview,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> getListLike(Map _body) async {
    Response response = await post(
      baseUrl + listLike,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> doLike(Map _body) async {
    Response response = await post(
      baseUrl + like,
      _body,
      headers: headerSignature,
    );
    return _handleResponse(response);
  }

  Future<dynamic> doViewAllNotification(Map _body) async {
    Response response = await post(
      baseUrl + viewAllNotification,
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
