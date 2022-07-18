// import 'package:appchat/pages/tab/tab.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../components/image_decoration.dart';
import '../../../components/start_rate.dart';
import '../../../components/text.dart';
import '../../../components/time_convert.dart';
import '../../../models/user.dart';
import '../../../services/http/getx_http.dart';
import '../../../services/socket/socket.dart';
import '../../../services/themes/app_theme.dart';

class MatchesController extends GetxController
    with GetTickerProviderStateMixin {
  final MyHttpProvider _httpProvider = Get.find();
  final MySocketController _socket = Get.find();
  // final MyTabController _tab = Get.find();

  final User _user = User();

  List listMatch = [];

  RxBool menuClose = false.obs;

  RxInt imageSlideIndex = 0.obs;

  RxDouble scrollBarPercentHeight = 0.0.obs;
  RxDouble scrollBarPercentHeightPosition = 0.0.obs;

  ScrollController imageSlideController = ScrollController();

  bool showScrollBar = false;

  late final AnimationController _menuIconController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final Animation<double> menuIconAnimation = CurvedAnimation(
    parent: _menuIconController,
    curve: Curves.easeOut,
  );

  late final AnimationController _scrollBarController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> scrollBarAnimation = CurvedAnimation(
    parent: _scrollBarController,
    curve: Curves.easeOut,
  );

  int page = 0;
  final int itemPerPage = 10;
  bool hasMore = true;

  SwipableStackController? swipableStackController;
  RxBool canSwipe = true.obs;
  int previousIndex = 0;

  @override
  onReady() async {
    super.onReady();

    swipableStackController = SwipableStackController()..addListener(() {});

    onFindMatch();
  }

  onFindMatch() async {
    if (hasMore) {
      Map _body = {"page": page, "item_per_page": itemPerPage};

      var _res = await _httpProvider.getFindMatch(_body);

      if (_res != null) {
        hasMore = _res.length == itemPerPage;

        if (page == 0) {
          listMatch = _res;
        } else {
          listMatch.removeAt(listMatch.length - 1);
          for (var i in _res) {
            listMatch.add(i);
          }
        }

        listMatch.add({});
        page += 1;

        update();
      }
    }
  }

  onClickCloseMenu() async {
    menuClose.value = !menuClose.value;

    if (menuClose.value) {
      _menuIconController.reset();
      _menuIconController.forward();
    } else {
      _menuIconController.reset();
    }
  }

  onSlideImage() {
    double _imageWidth = Get.width - 60;
    int _index = (imageSlideController.offset / _imageWidth).round();

    return onSlideToIndexImage(_index);
  }

  onSlideToIndexImage(index) {
    imageSlideIndex.value = index;
    double _imageWidth = Get.width - 52;
    imageSlideController.animateTo(_imageWidth * index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  onClickReview() async {
    Map _body = {
      "profile_id": listMatch[previousIndex + 1],
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
                    InkWell(
                      child: SvgPicture.asset(
                        'assets/svgs/close.svg',
                        color: AppTheme.colorWhite,
                      ),
                      onTap: () => Get.back(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                convertTimeAgo(time: _res[index]['time']),
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

  onSwipeCompleted(int index, SwipeDirection direction) {
    menuClose.value = true;
    onClickCloseMenu();
    imageSlideIndex.value = 0;
    previousIndex = index;
    canSwipe.value = (index < listMatch.length - 2);

    if (listMatch.length - index == itemPerPage / 2) {
      onFindMatch();
    }

    Map _currenMatch = listMatch[index];

    Map _body = {
      'like': direction == SwipeDirection.right,
      'user_id': _user.userID,
      'user_name': _user.fullName,
      'profile_id': _user.profileID,
      'profile_image': _user.avatarUrl,
      //
      'user_id_liked': _currenMatch['p_user_id'],
      'user_name_liked': _currenMatch['name'],
      'profile_id_liked': _currenMatch['_id'],
      'profile_image_liked': _currenMatch['avatar'],
    };

    if (direction == SwipeDirection.right) {
      _socket.socket.emit('send_like', _body);
    } else {
      _httpProvider.doLike(_body);
    }
  }

  onDragItemImageEnd(DragEndDetails detail, Map item) {
    int _imageIndex = imageSlideIndex.value;

    if (detail.primaryVelocity! > 0 && imageSlideIndex.value > 0) {
      _imageIndex--;
      onSlideToIndexImage(_imageIndex);
    } else if (detail.primaryVelocity! < 0) {
      if (imageSlideIndex.value < item['images'].length - 1) {
        _imageIndex++;
      }
      onSlideToIndexImage(_imageIndex);
    }
  }

  onHandleScrollUpdate(ScrollUpdateNotification data) {
    if (showScrollBar == false) {
      showScrollBar = true;
      _scrollBarController.forward();
    }
    if (data.depth == 0) {
      double _cardHeight =
          Get.height - Get.statusBarHeight - Get.bottomBarHeight;
      double _maxScroll = data.metrics.maxScrollExtent;

      if (scrollBarPercentHeight.value == 0.0) {
        scrollBarPercentHeight.value = _cardHeight / (_maxScroll + _cardHeight);
      }
      scrollBarPercentHeightPosition.value = data.metrics.pixels / _maxScroll;
    }
  }

  onHandleScrollEnd(ScrollEndNotification data) {
    showScrollBar = false;
    _scrollBarController.reverse();
  }
}
