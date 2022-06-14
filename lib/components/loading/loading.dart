import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_controller.dart';
import 'loading_state.dart';

void showLoading() async {
  final LoadingController _loadingController = Get.find();
  if (_loadingController.state is! Loading) {
    await _loadingController.showLoading();

    Get.dialog(
      WillPopScope(
          child: Center(
            child: Stack(
              children: [
                // RotationTransition(
                //   turns: _loadingController.animation,
                //   child: CustomPaint(
                //     size: Size(80, 80),
                //     painter: MyPainter(),
                //   ),
                // ),
                Positioned(
                  left: 1,
                  top: 1,
                  right: 1,
                  child: Container(
                    height: 78,
                    width: 78,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(39),
                      image: const DecorationImage(
                        image: AssetImage("assets/imgs/logo_app.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            ),
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
