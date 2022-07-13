// import 'package:appchat/pages/tab/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
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

  // RxMap currentMatch = {}.obs;
  // RxMap nextMatch = {}.obs;

  RxMap matchSwap0 = {}.obs;
  RxMap matchSwap1 = {}.obs;
  RxMap matchNext = {}.obs;
  RxInt indexStack = 0.obs;

  var _nextMatch = {};

  int nextIndex = 1;

  RxBool loaded = false.obs;

  RxBool menuClose = false.obs;

  RxInt imageSlideIndex = 0.obs;

  RxDouble scrollBarPercentHeight = 0.0.obs;
  RxDouble scrollBarPercentHeightPosition = 0.0.obs;

  ScrollController imageSlideController = ScrollController();

  Offset dragItemLocation = const Offset(0, 0);
  Offset? firstOffset;
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
  bool hasMore = true;

  @override
  onReady() async {
    super.onReady();

    // listMatch = await _tab.doPrecacheImage(0);
    // page = 1;

    onFindMatch();
  }

  onFindMatch() async {
    // if (hasMore) {
    //   List _listMatchCahceNext = await _tab.doPrecacheImage(page);

    //   if (_listMatchCahceNext.length >= 5) {
    //     page += 1;
    //   } else {
    //     hasMore = false;
    //   }

    //   listMatch.addAll(_listMatchCahceNext);

    Map _body = {"page": page, "item_per_page": 100};

    var _res = await _httpProvider.getFindMatch(_body);
    if (_res != null) {
      listMatch = [];
      for (var i in _res) {
        // FindUserModel _obj = FindUserModel().setData(i);
        listMatch.add(i);
      }

      // loaded.value = true;

      // if (listMatch.length > 1) {
      //   currentMatch.value = listMatch[0];
      //   _nextMatch = nextMatch.value = listMatch[1];
      // } else if (listMatch.length == 1) {
      //   currentMatch.value = listMatch[0];
      // }

      loaded.value = true;

      if (listMatch.length > 1) {
        matchSwap0.value = listMatch[0];
        _nextMatch = matchSwap1.value = matchNext.value = listMatch[1];
      } else if (listMatch.length == 1) {
        matchSwap0.value = listMatch[0];
      }
    }

    // Map _body = {"page": page, "item_per_page": 20};

    // var _res = await _httpProvider.getFindMatch(_body);
    // if (_res != null) {
    // listMatch = [];
    // for (var i in _res) {
    //   // FindUserModel _obj = FindUserModel().setData(i);
    //   listMatch.add(i);
    // }

    // loaded.value = true;

    // if (listMatch.length > 1) {
    //   matchSwap0.value = listMatch[0];
    //   _nextMatch = matchSwap1.value = matchNext.value = listMatch[1];
    // } else if (listMatch.length == 1) {
    //   matchSwap0.value = listMatch[0];
    // }
    // }
    // }
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
    double _imageWidth = Get.width - 60;
    imageSlideController.animateTo(_imageWidth * index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  // onClickReview() async {
  //   Map _body = {
  //     "profile_id": currentMatch['_id'],
  //     "page": 0,
  //     "item_per_page": 20
  //   };
  //   var _res = await _httpProvider.getListReview(_body);

  //   if (_res != null && _res.length > 0) {
  //     Get.bottomSheet(
  //       SafeArea(
  //         child: Container(
  //           height: Get.height - Get.statusBarHeight,
  //           alignment: Alignment.center,
  //           padding: const EdgeInsets.all(20),
  //           decoration: BoxDecoration(
  //               borderRadius: const BorderRadius.only(
  //                 topRight: Radius.circular(20),
  //                 topLeft: Radius.circular(20),
  //               ),
  //               color: AppTheme.colorBackgroundDark),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Row(
  //                 children: [
  //                   InkWell(
  //                     child: SvgPicture.asset(
  //                       'assets/svgs/close.svg',
  //                       color: AppTheme.colorWhite,
  //                     ),
  //                     onTap: () => Get.back(),
  //                   ),
  //                   Expanded(
  //                     child: TextCustom(
  //                       '20 ${'review'.tr}',
  //                       style: AppTheme.textStyle20.bold(),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 24)
  //                 ],
  //               ),
  //               const SizedBox(height: 20),
  //               Expanded(
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     children: List.generate(
  //                       _res.length,
  //                       (index) => Container(
  //                         padding: const EdgeInsets.only(bottom: 20),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Container(
  //                                   height: 40,
  //                                   width: 40,
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(20),
  //                                     image: myImageDecoration(
  //                                         _res[index]['avatar']),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(width: 10),
  //                                 Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     TextCustom(
  //                                       _res[index]['user_name'],
  //                                       style: AppTheme.textStyle18.bold(),
  //                                     ),
  //                                     const SizedBox(height: 2),
  //                                     myStarRate(
  //                                         10, _res[index]['rate'].toDouble())
  //                                   ],
  //                                 )
  //                               ],
  //                             ),
  //                             const SizedBox(height: 8),
  //                             TextCustom(
  //                               _res[index]['content'],
  //                               style: AppTheme.textStyle,
  //                             ),
  //                             const SizedBox(height: 4),
  //                             TextCustom(
  //                               convertTimeAgo(time: _res[index]['time']),
  //                               style: AppTheme.textStyleSub.grey(),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       isScrollControlled: true,
  //     );
  //   } else {
  //     AwesomeDialog(
  //       context: Get.context!,
  //       dialogType: DialogType.WARNING,
  //       animType: AnimType.BOTTOMSLIDE,
  //       autoHide: const Duration(seconds: 2),
  //       desc: 'no_review'.tr,
  //     ).show();
  //   }
  // }

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

  onDragItemUpdate(DragUpdateDetails detail) {
    firstOffset ??= detail.localPosition;

    dragItemLocation = Offset(detail.localPosition.dx - firstOffset!.dx,
        detail.localPosition.dy - firstOffset!.dy);
    update();
  }

  onDragItemEnd(DragEndDetails detail) {
    if (detail.primaryVelocity! != 0) {
      _doAcceptOrDecline(detail.primaryVelocity! > 0);
    } else {
      double _value = (dragItemLocation.dx + firstOffset!.dx) - Get.width * 0.5;
      if (_value.abs() > (Get.width * 0.3)) {
        _doAcceptOrDecline(_value > 0);
      }
    }
    dragItemLocation = const Offset(0, 0);
    firstOffset = null;

    update();
  }

  _doAcceptOrDecline(bool like) {
    Map _currenMatch = getCurrentMatch();

    Map _body = {
      'like': like,
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

    if (like) {
      _socket.socket!.emit('send_like', _body);
    } else {
      _httpProvider.doLike(_body);
    }

    indexStack.value = (indexStack.value - 1).abs();

    if (indexStack.value == 0) {
      matchSwap0.value = _nextMatch;
    } else {
      matchSwap1.value = _nextMatch;
    }

    nextIndex += 1;
    if (nextIndex < listMatch.length) {
      _nextMatch = listMatch[nextIndex];
      matchNext.value = _nextMatch;
    } else {
      _nextMatch = {};
      matchNext.value = {};
    }
  }

  onDragItemImageEnd(DragEndDetails detail) {
    int _imageIndex = imageSlideIndex.value;

    if (detail.primaryVelocity! > 0 && imageSlideIndex.value > 0) {
      _imageIndex--;
      onSlideToIndexImage(_imageIndex);
    } else if (detail.primaryVelocity! < 0) {
      if ((indexStack.value == 0 &&
              imageSlideIndex.value < matchSwap0['images'].length - 1) ||
          (indexStack.value == 0 &&
              imageSlideIndex.value < matchSwap0['images'].length - 1)) {
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

  Map getCurrentMatch() {
    if (indexStack.value == 0) {
      return matchSwap0;
    } else {
      return matchSwap0;
    }
  }
}
