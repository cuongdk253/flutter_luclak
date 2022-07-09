import 'dart:ui';

import 'package:appchat/models/chat_user.dart';
import 'package:appchat/services/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../components/time_convert.dart';
import '../../services/themes/app_theme.dart';
import 'list_chat.dart';

class ListChatView extends GetView<ListChatController> {
  final ListChatController c = Get.put(ListChatController());

  ListChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackgroundHeader,
      appBar: mAppBar(),
      body: mBody(),
    );
  }

  AppBar mAppBar() {
    return AppBar(
      backgroundColor: AppTheme.colorBackgroundHeader,
      centerTitle: true,
      leadingWidth: 0,
      elevation: 0,
      leading: const SizedBox(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: SvgPicture.asset(
              'assets/svgs/menu.svg',
              color: AppTheme.colorText,
            ),
          ),
          InkWell(
            child: SvgPicture.asset(
              'assets/svgs/search.svg',
              color: AppTheme.colorText,
            ),
          )
        ],
      ),
      bottom: PreferredSize(
        child: Container(
          color: AppTheme.colorGreyText,
          height: 1.0,
        ),
        preferredSize: const Size.fromHeight(3.0),
      ),
    );
  }

  Widget mBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              TextCustom(
                'match_queue'.tr,
                style: AppTheme.textStyle18.medium(),
              ),
              const SizedBox(width: 4),
              TextCustom(
                '(3)',
                style: AppTheme.textStyle18.medium().grey(),
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 16),
              _likeYou(),
              const SizedBox(width: 16),
              _matchStack(),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 2,
          width: Get.width,
          color: AppTheme.colorGreyText1,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    TextCustom(
                      'conversation'.tr,
                      style: AppTheme.textStyle18.medium(),
                    ),
                    const SizedBox(width: 4),
                    TextCustom(
                      '(${'resent'.tr})',
                      style: AppTheme.textStyle18.medium().grey(),
                    )
                  ],
                ),
              ),
              SvgPicture.asset('assets/svgs/menu1.svg')
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: _listMatchSort(),
          ),
        )
      ],
    );
  }

  Widget _likeYou() {
    return Obx(() => c.listLikeYou.isNotEmpty
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              const SizedBox(
                height: 70,
                width: 60,
              ),
              Positioned(
                left: 10,
                bottom: 6,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(9 / 360),
                  child: _blurImage(
                    height: 60,
                    width: 45,
                    imageDecoration: c.listLikeYou[0].profileImageDecoration,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                bottom: 6,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(-3 / 360),
                  child: _blurImage(
                    height: 60,
                    width: 45,
                    imageDecoration: c.listLikeYou[1].profileImageDecoration,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 3,
                      color: AppTheme.colorBackgroundHeader,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppTheme.colorPrimary,
                    ),
                    child: TextCustom(
                      c.listLikeYou.length.toString(),
                      style: AppTheme.textStyle
                          .white()
                          .bold()
                          .copyWith(fontSize: 12),
                    ),
                  ),
                ),
              )
            ],
          )
        : const SizedBox());
  }

  Widget _matchStack() {
    return Obx(() => Row(
          children: List.generate(
            c.listDataMatchQueue.length,
            (index) => InkWell(
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
                    padding: const EdgeInsets.all(10),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 2.5,
                        color: AppTheme.colorGreyText,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          image: c
                              .listDataMatchQueue[index].profileImageDecoration,
                          borderRadius: BorderRadius.circular(40)),
                    ),
                  ),
                  Container(
                    height: 78,
                    width: 78,
                    margin: const EdgeInsets.all(1),
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      value: c.listDataMatchQueue[index].process,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.purple),
                    ),
                  )
                ],
              ),
              onTap: () => c.onClickItem(c.listDataMatchQueue[index]),
            ),
          ),
        ));
  }

  Widget _listMatchSort() {
    return GetBuilder<ListChatController>(
      builder: (_) => Obx(() => Column(
            children: List.generate(
              c.listData.length,
              (index) => InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.5,
                        color: AppTheme.colorGreyText1,
                      ),
                    ),
                  ),
                  child: Row(children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          height: 80,
                          width: 80,
                          decoration:
                              c.listData[index].chatType != ChatModelType.normal
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        width: 2.5,
                                        color: AppTheme.colorGreyText,
                                      ),
                                    )
                                  : null,
                          child: Container(
                            decoration: BoxDecoration(
                                image: c.listData[index].profileImageDecoration,
                                borderRadius: BorderRadius.circular(40)),
                          ),
                        ),
                        c.listData[index].chatType ==
                                ChatModelType.incomingExpire
                            ? Container(
                                height: 80,
                                width: 80,
                                padding: const EdgeInsets.all(1),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  value: c.listData[index].process,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.purple),
                                ),
                              )
                            : const SizedBox(),
                        c.listData[index].chatType == ChatModelType.expire
                            ? Positioned(
                                bottom: 2,
                                right: 2,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppTheme.colorBackgroundHeader,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppTheme.colorGreyText,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 80,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextCustom(
                                  c.listData[index].userName,
                                  style: AppTheme.textStyle18.bold(),
                                ),
                                _chatContent(c.listData[index])
                              ],
                            ),
                            c.listData[index].chatType ==
                                    ChatModelType.incomingExpire
                                ? Positioned(
                                    right: 0,
                                    top: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      decoration: BoxDecoration(
                                          color: AppTheme.colorPrimary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: TextCustom(
                                        'your_move'.tr,
                                        style: AppTheme.textStyleSub,
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
                onTap: () => c.onClickItem(c.listData[index]),
              ),
            ),
          )),
    );
  }

  Widget _chatContent(ChatUserModel item) {
    if (item.chatType == ChatModelType.normal) {
      return TextCustom(
        item.lastMessage.message,
        style: AppTheme.textStyle16.grey(),
      );
    } else if (item.chatType == ChatModelType.incomingExpire) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextCustom(
            item.lastMessage.message,
            style: AppTheme.textStyle16.grey(),
          ),
          Row(
            children: [
              TextCustom(
                'conversation_expire_in'.tr,
                style: AppTheme.textStyleSub.grey(),
              ),
              const SizedBox(width: 4),
              TextCustom(
                timeCaculate(time: item.time),
                style: AppTheme.textStyleSub.yellow(),
              )
            ],
          )
        ],
      );
    } else {
      return TextCustom(
        '${'expire'.tr} ${convertTimeAgo(time: item.time)}',
        style: AppTheme.textStyle16.grey(),
      );
    }
  }

  Widget _blurImage({
    required double height,
    required double width,
    required DecorationImage imageDecoration,
  }) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: imageDecoration,
          ),
        ),
        Positioned(
          width: width,
          height: height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
