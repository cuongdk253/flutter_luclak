// import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import 'loading_state.dart';

class LoadingController extends GetxController {
  final _loadingStateStream = const LoadingState().obs;

  LoadingState get state => _loadingStateStream.value;

  void setState(data) => _loadingStateStream.value = UnLoading();

  // AnimationController _rotationController;
  // Animation<double> animation;

  // @override
  // void onInit() {
  //   super.onInit();
  //   _rotationController = AnimationController(
  //     duration: Duration(milliseconds: 1500),
  //     vsync: this,
  //   );
  //   animation = CurvedAnimation(
  //     parent: _rotationController,
  //     curve: Curves.linear,
  //   );
  // }

  Future<void> showLoading() async {
    // _rotationController.repeat();
    _loadingStateStream.value = Loading();
  }

  Future<void> hideLoading() async {
    _loadingStateStream.value = UnLoading();
  }
}
