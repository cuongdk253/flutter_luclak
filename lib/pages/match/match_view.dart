import 'package:appchat/services/http/cmd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../services/themes/app_theme.dart';
import 'match.dart';

class MatchesView extends GetView<MatchesController> {
  final MatchesController c = Get.put(MatchesController());

  MatchesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.colorWhite,
        centerTitle: true,
        leadingWidth: 0,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              child: SvgPicture.asset('assets/svgs/menu.svg'),
            ),
            TextCustom(
              'Luc•Lak',
              style: AppTheme.textStyle18.primary().medium(),
            ),
            InkWell(
              child: SvgPicture.asset('assets/svgs/sort.svg'),
            )
          ],
        ),
      ),
      body: mBody(context),
    );
  }

  Widget mBody(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: LayoutBuilder(
        builder: (context, constraints) => Obx(() => c.currentMatch.isNotEmpty
            ? Draggable(
                feedback:
                    _itemDrag(constraints.maxWidth, constraints.maxHeight),
                childWhenDragging:
                    _nextItem(constraints.maxWidth, constraints.maxHeight),
                child: _matchItem(constraints.maxWidth, constraints.maxHeight),
                onDragEnd: (data) => c.handleDrag(data.offset.dx),
              )
            : _noMatch()),
      ),
    );
  }

  Widget _nextItem(double width, double height) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Obx(() => c.nextMatch.isNotEmpty
            ? Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(baseUrl + c.nextMatch['avatar']),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.8, 1.0],
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 24,
                    child: TextCustom(
                      c.nextMatch['name'],
                      style: AppTheme.textStyle20.bold().white(),
                    ),
                  ),
                ],
              )
            : const SizedBox()),
      ),
    );
  }

  Widget _matchItem(double width, double height) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Obx(() => c.currentMatch.isNotEmpty
            ? Container(
                color: AppTheme.colorBackground1,
                child: ListView(children: [
                  Stack(
                    children: [
                      Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  baseUrl + c.currentMatch['avatar']),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.8, 1.0],
                            colors: [
                              Colors.black.withOpacity(0.0),
                              Colors.black.withOpacity(0.2),
                              Colors.black.withOpacity(0.6),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 24,
                        child: TextCustom(
                          c.currentMatch['name'],
                          style: AppTheme.textStyle20.bold().white(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: TextCustom(
                              '\$200-\$500',
                              style: AppTheme.textStyle16.medium(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: TextCustom(
                              'About Me',
                              style: AppTheme.textStyle18.medium(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8),
                            child: TextCustom(
                              c.currentMatch['about'],
                              style: AppTheme.textStyle16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            child: TextCustom(
                              'My Favorite',
                              style: AppTheme.textStyle18.medium(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 16, right: 16, bottom: 16),
                            child: Wrap(
                              children: List.generate(
                                  c.currentMatch['favorites'].length,
                                  (index) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        margin: const EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                                color: AppTheme.colorGreyText)),
                                        child: TextCustom(
                                            c.currentMatch['favorites'][index]),
                                      )),
                            ),
                          ),
                          SizedBox(
                            child: Column(
                                children: List.generate(
                              c.currentMatch['images'].length,
                              (index) => Container(
                                  height: height * 0.7,
                                  width: width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(baseUrl +
                                            c.currentMatch['images'][index]),
                                        fit: BoxFit.cover),
                                  )),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16, bottom: 20),
                            child: TextCustom(
                              c.currentMatch['address'],
                              style: AppTheme.textStyle18.bold(),
                            ),
                          ),
                          SizedBox(
                            height: 140,
                            width: width,
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    left: (width / 2) - 40,
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: SvgPicture.asset(
                                          'assets/svgs/hex.svg'),
                                    )),
                                Positioned(
                                  top: 0,
                                  left: (width / 2) - 40,
                                  child: InkWell(
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      padding: const EdgeInsets.all(20),
                                      child: SizedBox(
                                        child: SvgPicture.asset(
                                          'assets/svgs/star.svg',
                                          color: AppTheme.colorWhite,
                                        ),
                                      ),
                                    ),
                                    onTap: () => {},
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 32,
                                  child: InkWell(
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: AppTheme.colorPrimary,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/svgs/decline.svg',
                                        color: AppTheme.colorWhite,
                                      ),
                                    ),
                                    onTap: () => c.onClickDecline(),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 32,
                                  child: InkWell(
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: AppTheme.colorPrimary,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/svgs/accept.svg',
                                        color: AppTheme.colorWhite,
                                      ),
                                    ),
                                    onTap: () => c.onClickAccept(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                        ]),
                  ),
                ]),
              )
            : const SizedBox()),
      ),
    );
  }

  Widget _itemDrag(double width, double height) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Obx(() => c.currentMatch.isNotEmpty
            ? Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              NetworkImage(baseUrl + c.currentMatch['avatar']),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.8, 1.0],
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox()),
      ),
    );
  }

  Widget _noMatch() {
    return Obx(() => c.loaded.value
        ? Container(
            alignment: Alignment.center,
            child: const TextCustom('hết rồi!'),
          )
        : const SizedBox());
  }
}
