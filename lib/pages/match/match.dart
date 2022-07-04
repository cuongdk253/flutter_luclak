import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/user.dart';
import '../../services/http/getx_http.dart';

class MatchesController extends GetxController
    with GetTickerProviderStateMixin {
  final MyHttpProvider _httpProvider = Get.find();

  final User _user = User();

  List listMatch = [];

  RxMap currentMatch = {}.obs;

  RxMap nextMatch = {}.obs;

  var _nextMatch = {};

  int nextIndex = 1;

  RxBool loaded = false.obs;

  RxBool menuClose = true.obs;

  RxInt imageSlideIndex = 0.obs;

  RxDouble scrollBarPercentHeight = 0.0.obs;
  RxDouble scrollBarPercentHeightPosition = 0.0.obs;

  ScrollController scrollController = ScrollController();
  ScrollController imageSlideController = ScrollController();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  @override
  onReady() async {
    super.onReady();

    scrollController.addListener(() {
      double _cardHeight =
          Get.height - Get.statusBarHeight - Get.bottomBarHeight;
      double _maxScroll = scrollController.position.maxScrollExtent;

      if (scrollBarPercentHeight.value == 0.0) {
        scrollBarPercentHeight.value = _cardHeight / (_maxScroll + _cardHeight);
      }

      scrollBarPercentHeightPosition.value =
          scrollController.offset / _maxScroll;
    });

    imageSlideController.addListener(() {
      final extentAfter = imageSlideController.position.extentAfter;

      debugPrint(extentAfter.toString());
    });

    onFindMatch();
  }

  onFindMatch() async {
    Map _body = {"username": _user.username};
    var _res = await _httpProvider.getFindMatch(_body);
    if (_res != null) {
      listMatch = [];
      for (var i in _res) {
        // FindUserModel _obj = FindUserModel().setData(i);
        listMatch.add(i);
      }

      loaded.value = true;

      if (listMatch.length > 1) {
        currentMatch.value = listMatch[0];
        _nextMatch = nextMatch.value = listMatch[1];
      } else if (listMatch.length == 1) {
        currentMatch.value = listMatch[0];
      }
    }
  }

  handleDrag(double dx) {
    if (dx.abs() > Get.width / 2) {
      currentMatch.value = _nextMatch;
      nextIndex += 1;
      if (nextIndex < listMatch.length) {
        _nextMatch = listMatch[nextIndex];
        nextMatch.value = _nextMatch;
      } else {
        _nextMatch = {};
        nextMatch.value = {};
      }
    }
  }

  onClickAccept() {
    handleDrag(Get.width);
  }

  onClickDecline() {
    handleDrag(Get.width);
  }

  onClickCloseMenu() async {
    menuClose.value = !menuClose.value;

    if (menuClose.value) {
      _controller.reset();
      _controller.forward();
    } else {
      _controller.reset();
    }
  }

  onSlideImage() {
    double _imageWidth = Get.width - 60;
    int _index = (imageSlideController.offset / _imageWidth).round();
    // imageSlideIndex.value = _index;

    // debugPrint((_imageWidth * _index).toString());

    // imageSlideController.animateTo(1000,
    //     duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

    return onSlideToIndexImage(_index);
  }

  onSlideToIndexImage(index) {
    imageSlideIndex.value = index;
    double _imageWidth = Get.width - 60;
    imageSlideController.animateTo(_imageWidth * index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
