import 'package:appchat/components/start_rate.dart';
import 'package:appchat/components/text.dart';
import 'package:appchat/services/themes/app_theme.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../components/image_decoration.dart';
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

  onClickReview() async {
    int _now = DateTime.now().millisecondsSinceEpoch;

    Map _body = {
      "profile_id": currentMatch['_id'],
      "page": 0,
      "item_per_page": 20
    };
    var _res = await _httpProvider.getListReview(_body);

    if (_res != null && _res.length > 0) {
      Get.bottomSheet(
        SafeArea(
          child: Container(
            height: Get.height - Get.statusBarHeight,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: AppTheme.colorBackgroundDark),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/close.svg',
                      color: AppTheme.colorWhite,
                    ),
                    Expanded(
                      child: TextCustom(
                        '20 ${'review'.tr}',
                        style: AppTheme.textStyle20.bold(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 24)
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        _res.length,
                        (index) => Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: myImageDecoration(
                                          _res[index]['avatar']),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    children: [
                                      TextCustom(
                                        _res[index]['user_name'],
                                        style: AppTheme.textStyle18.bold(),
                                      ),
                                      const SizedBox(height: 2),
                                      myStarRate(
                                          10, _res[index]['rate'].toDouble())
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextCustom(
                                _res[index]['content'],
                                style: AppTheme.textStyle,
                              ),
                              const SizedBox(height: 4),
                              TextCustom(
                                _timeCaculate(_now, _res[index]['time']),
                                style: AppTheme.textStyleSub.grey(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        isScrollControlled: true,
      );
    } else {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        autoHide: const Duration(seconds: 2),
        desc: 'no_review'.tr,
      ).show();
    }
  }

  showAlertWellcome() {
    Get.bottomSheet(
      SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: Get.width,
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppTheme.colorBackgroundDark),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                SvgPicture.asset(
                  'assets/svgs/logo.svg',
                  color: AppTheme.colorWhite,
                ),
                const SizedBox(height: 48),
                TextCustom(
                  'time_to_catch'.tr,
                  style: AppTheme.textStyle18.bold(),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextCustom(
                    'des_time_to_catch'.tr,
                    style: AppTheme.textStyle16,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                InkWell(
                  child: Container(
                    height: 44,
                    width: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: AppTheme.gradient),
                    child: TextCustom(
                      'start_swiping'.tr,
                      style: AppTheme.textStyle18.bold().white(),
                    ),
                  ),
                  // onTap: () => c.onClickNext(),
                ),
                const SizedBox(height: 24),
              ],
            ),
          )
        ]),
      ),
      isScrollControlled: true,
    );
  }

  String _timeCaculate(int _now, int _time) {
    double _seconds = (_now - _time) / 1000;
    if (_seconds < 60) {
      return 'now_ago'.tr;
    } else if (_seconds >= 60 && _seconds < 3600) {
      return '${(_seconds / 60).toStringAsFixed(0)} ${'minute_ago'.tr}';
    } else if (_seconds >= 3600 && _seconds < 86400) {
      return '${(_seconds / 3600).toStringAsFixed(0)} ${'hour_ago'.tr}';
    } else {
      return DateFormat('dd-MM-yyyy')
          .format(DateTime.fromMillisecondsSinceEpoch(_time));
    }
  }
}
