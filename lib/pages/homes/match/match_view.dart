import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../components/card_swipe.dart';
import '../../../components/check.dart';
import '../../../components/image_decoration.dart';
import '../../../components/start_rate.dart';
import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import '../../header_bar/header_bar_view.dart';
import 'match.dart';

class MatchesView extends GetView<MatchesController> {
  final MatchesController c = Get.put(MatchesController());
  MatchesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackgroundHeader,
      appBar: HeaderBarView(),
      body: mBody(),
    );
  }

  Widget mBody() {
    return SafeArea(
      child: Stack(
        children: [
          GetBuilder<MatchesController>(
            builder: (_) => c.swipableStackController != null
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: SwipableStack(
                      controller: c.swipableStackController,
                      stackClipBehaviour: Clip.none,
                      allowVerticalSwipe: false,
                      onWillMoveNext: (index, swipeDirection) {
                        // Return true for the desired swipe direction.
                        switch (swipeDirection) {
                          case SwipeDirection.left:
                          case SwipeDirection.right:
                            return c.canSwipe.value;
                          case SwipeDirection.up:
                          case SwipeDirection.down:
                            return false;
                        }
                      },
                      onSwipeCompleted: (index, direction) =>
                          c.onSwipeCompleted(index, direction),
                      horizontalSwipeThreshold: 0.8,
                      // Set max value to ignore vertical threshold.
                      verticalSwipeThreshold: 1,
                      overlayBuilder: (context, properties) => CardOverlay(
                        swipeProgress: properties.swipeProgress,
                        direction: properties.direction,
                      ),
                      builder: (context, properties) {
                        final Map item = c.listMatch[(properties.index)
                            .clamp(0, c.listMatch.length - 1)];
                        if (item.isNotEmpty) {
                          return _matchItem(item: item);
                        } else {
                          return _noMatch();
                        }
                      },
                    ),
                  )
                : const SizedBox(),
          ),
          Obx(() => !c.canSwipe.value ? _noMatch() : const SizedBox()),
        ],
      ),
    );
  }

  Widget _matchItem({required Map item}) {
    double height = Get.height - Get.statusBarHeight - Get.bottomBarHeight - 64;
    double width = Get.width - 16;
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: item.isNotEmpty
            ? Stack(
                children: [
                  Container(
                    color: AppTheme.colorGreyText1,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification) {
                          c.onHandleScrollUpdate(scrollNotification);
                        } else if (scrollNotification
                            is ScrollEndNotification) {
                          c.onHandleScrollEnd(scrollNotification);
                        }
                        return false;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _introduce(item, width, height),
                            _description(item),
                            _imageSlider(item),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    bottom: 32,
                    child: _scroll(),
                  )
                ],
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _scroll() {
    return Obx(() => FadeTransition(
          opacity: c.scrollBarAnimation,
          child: Container(
            height: 72,
            width: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: AppTheme.colorGreyText,
            ),
            child: Container(
              margin: EdgeInsets.only(
                  top: ((72.0 - 72.0 * c.scrollBarPercentHeight.value) *
                          c.scrollBarPercentHeightPosition.value)
                      .clamp(0.0, 72.0),
                  bottom: (72.0 * (1 - c.scrollBarPercentHeight.value) -
                          (72.0 - 72.0 * c.scrollBarPercentHeight.value) *
                              c.scrollBarPercentHeightPosition.value)
                      .clamp(0.0, 72.0)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppTheme.colorWhite,
              ),
            ),
          ),
        ));
  }

  Widget _introduce(Map item, double width, double height) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: myImageDecoration(item['images'][0]),
          ),
        ),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.15, 0.4, 0.7, 1.0],
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
        ),
        Positioned(
          top: 16,
          left: 18,
          child: InkWell(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    item['name'],
                    style: AppTheme.textStyle20.bold().white(),
                  ),
                  item['rate'] != null
                      ? Container(
                          padding: const EdgeInsets.only(top: 2),
                          child: myStarRate(14, item['rate'].toDouble()),
                        )
                      : const SizedBox()
                ],
              ),
              const SizedBox(width: 8),
              item['hot'] == true
                  ? Container(
                      padding: const EdgeInsets.only(top: 4),
                      child: MyCheckbox(
                          isChecked: true, selectedColor: AppTheme.colorBlue),
                    )
                  : const SizedBox()
            ]),
            onTap: () => c.onClickReview(),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                child: Obx(
                  () => !c.menuClose.value
                      ? Stack(children: [
                          Container(
                            height: 42,
                            width: 42,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppTheme.colorWhite,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                image: myImageDecoration(item['avatar']),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppTheme.colorWhite,
                              ),
                              child: SvgPicture.asset('assets/svgs/down.svg'),
                            ),
                          )
                        ])
                      : Container(
                          height: 36,
                          width: 36,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppTheme.colorTextDark,
                          ),
                          child: SvgPicture.asset(
                            'assets/svgs/close.svg',
                            color: AppTheme.colorWhite,
                          ),
                        ),
                ),
                onTap: () => c.onClickCloseMenu(),
              ),
              FadeTransition(
                opacity: c.menuIconAnimation,
                child: Container(
                  height: 42,
                  width: 42,
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppTheme.colorWhite,
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/chat1.svg',
                    color: AppTheme.colorTextDark,
                  ),
                ),
              ),
              FadeTransition(
                opacity: c.menuIconAnimation,
                child: Container(
                  height: 42,
                  width: 42,
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppTheme.colorWhite,
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/phone.svg',
                    color: AppTheme.colorTextDark,
                  ),
                ),
              ),
              FadeTransition(
                opacity: c.menuIconAnimation,
                child: Container(
                  height: 42,
                  width: 42,
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: AppTheme.colorWhite,
                  ),
                  child: SvgPicture.asset(
                    'assets/svgs/mail.svg',
                    color: AppTheme.colorTextDark,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          left: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item['money_from'] != null
                  ? TextCustom(
                      '\$ ${NumberFormat().format(item['money_from'])} - \$ ${NumberFormat().format(item['money_to'])}',
                      style: AppTheme.textStyle20
                          .bold()
                          .white()
                          .copyWith(fontSize: 30),
                    )
                  : const SizedBox(),
              item['jobs'] != null
                  ? TextCustom(
                      _job(item['jobs']),
                      style: AppTheme.textStyle20.white(),
                    )
                  : const SizedBox(),
              item['favorites'] != null
                  ? TextCustom(
                      _favorite(item['favorites']),
                      style: AppTheme.textStyle20.white(),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ],
    );
  }

  Widget _description(Map item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 16),
          child: Row(
            children: [
              SvgPicture.asset('assets/svgs/logo_facebook.svg'),
              const SizedBox(width: 8),
              SizedBox(
                width: Get.width * 0.3,
                child: TextCustom(
                  'Facebook',
                  style: AppTheme.textStyle16,
                ),
              ),
              Expanded(
                child: TextCustom(
                  item['facebook_view'] != null
                      ? _socialWiew(item['facebook_view'].toDouble())
                      : 'no_update'.tr,
                  style: AppTheme.textStyle16.bold(),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 16),
          child: Row(
            children: [
              SvgPicture.asset('assets/svgs/logo_tiktok.svg'),
              const SizedBox(width: 8),
              SizedBox(
                width: Get.width * 0.3,
                child: TextCustom(
                  'Tiktok',
                  style: AppTheme.textStyle16,
                ),
              ),
              Expanded(
                child: TextCustom(
                  item['facebook_view'] != null
                      ? _socialWiew(item['tiktok_view'].toDouble())
                      : 'no_update'.tr,
                  style: AppTheme.textStyle16.bold(),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 18, right: 18, top: 16),
          child: Row(
            children: [
              SvgPicture.asset('assets/svgs/logo_instagram.svg'),
              const SizedBox(width: 8),
              SizedBox(
                width: Get.width * 0.3,
                child: TextCustom(
                  'Instagram',
                  style: AppTheme.textStyle16,
                ),
              ),
              Expanded(
                child: TextCustom(
                  item['facebook_view'] != null
                      ? _socialWiew(item['instagram_view'].toDouble())
                      : 'no_update'.tr,
                  style: AppTheme.textStyle16.bold(),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 18, right: 18, top: 18),
          padding: const EdgeInsets.symmetric(vertical: 18),
          width: Get.width,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(
              width: 0.5,
              color: AppTheme.colorBackground,
            ),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                'description'.tr,
                style: AppTheme.textStyle18.bold(),
              ),
              const SizedBox(height: 8),
              TextCustom(
                item['about'],
                style: AppTheme.textStyle,
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 18, right: 18, top: 18),
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(
              width: 0.5,
              color: AppTheme.colorBackground,
            ),
          )),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextCustom(
              'power'.tr,
              style: AppTheme.textStyle18.bold(),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                2,
                (index) => Expanded(
                    child: Row(
                  children: [
                    SvgPicture.asset('assets/svgs/check1.svg'),
                    const SizedBox(width: 10),
                    TextCustom(
                      item['powers'][index],
                      style: AppTheme.textStyle16.medium(),
                    )
                  ],
                )),
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget _imageSlider(Map item) {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 18),
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: AppTheme.colorBackground,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SingleChildScrollView(
              controller: c.imageSlideController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  item['images'].length - 1,
                  (index) => Container(
                    height: Get.width - 52,
                    width: Get.width - 52,
                    decoration: BoxDecoration(
                      image: myImageDecoration(item['images'][index + 1]),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: Get.width - 52,
                width: Get.width - 52,
                color: Colors.transparent,
              ),
              onHorizontalDragEnd: (DragEndDetails detai) =>
                  c.onDragItemImageEnd(detai, item),
            ),
            Positioned(
              bottom: 12,
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      item['images'].length - 1,
                      (index) => InkWell(
                        child: Container(
                          height: 10,
                          width: 10,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: c.imageSlideIndex.value == index
                                ? AppTheme.colorWhite
                                : AppTheme.colorGreyText,
                          ),
                        ),
                        onTap: () => c.onSlideToIndexImage(index),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _noMatch() {
    return Container(
      // height: Get.height - Get.statusBarHeight - Get.bottomBarHeight + 8,
      // width: Get.width - 16,
      height: Get.height,
      width: Get.width,
      color: AppTheme.colorBackgroundHeader,
      alignment: Alignment.center,
      child: const TextCustom('hết rồi!'),
    );
  }

  String _job(List list) {
    String _myString = '';
    for (String i in list) {
      _myString = _myString + ', ' + i;
    }
    return _myString.substring(2);
  }

  String _favorite(List list) {
    String _myString = '';
    for (String i in list) {
      _myString = _myString + ' | ' + i;
    }
    return _myString.substring(3);
  }

  String _socialWiew(double number) {
    double _kNumber = number / 1000;

    if (_kNumber < 1) {
      return number.toString();
    } else {
      double _mNumber = _kNumber / 1000;
      if (_mNumber < 1) {
        if (number % 1000 > 100) {
          return _kNumber.toStringAsFixed(1) + 'k';
        } else {
          return _kNumber.toStringAsFixed(0) + 'k';
        }
      } else {
        if (_kNumber % 1000 > 100) {
          return _mNumber.toStringAsFixed(1) + 'm';
        } else {
          return _mNumber.toStringAsFixed(0) + 'm';
        }
      }
    }
  }
}
