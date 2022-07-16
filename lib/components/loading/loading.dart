import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'loading_controller.dart';
import 'loading_state.dart';

void showLoading() async {
  final LoadingController _loadingController = Get.find();
  if (_loadingController.state is! Loading) {
    await _loadingController.showLoading();

    Get.dialog(
      WillPopScope(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            ],
          ),
          onWillPop: () async => _loadingController.state is UnLoading),
      barrierDismissible: false,
    );
  }
}

hideLoading() async {
  final LoadingController _loadingController = Get.find();
  if (_loadingController.state is Loading) {
    await _loadingController.hideLoading();
    Get.back();
  }
}
