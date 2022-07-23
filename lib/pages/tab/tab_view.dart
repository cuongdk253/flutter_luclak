import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../services/themes/app_theme.dart';
import '../chats/list_chat/list_chat_view.dart';
import '../homes/match/match_view.dart';
import '../likes/like_you/like_you_view.dart';
import '../personals/personal/personal_view.dart';
import 'tab.dart';

class MyTabView extends GetView<MyTabController> {
  final MyTabController c = Get.put(MyTabController());

  MyTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mBody(context),
      bottomNavigationBar: mTab(),
    );
  }

  Widget mBody(context) {
    return SizedBox(
      child: Obx(() {
        return IndexedStack(
          index: c.tabIndex.value,
          children: [
            MatchesView(),
            LikedYouView(),
            ListChatView(),
            PersonalView(),
          ],
        );
      }),
    );
  }

  Widget mTab() {
    return Container(
      color: AppTheme.colorBackgroundHeader,
      child: Obx(() => SafeArea(
            child: SizedBox(
              height: 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(c.myTab.length, (index) {
                  return Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () => c.onClickTab(index),
                          child: SvgPicture.asset(
                            index == 0
                                ? c.myTab[index]['icon_active']!
                                : c.myTab[index]['icon']!,
                            width: 32,
                            height: 32,
                            color: index == c.tabIndex.value
                                ? index != 0
                                    ? AppTheme.colorSecondary
                                    : null
                                : AppTheme.colorGreyText,
                          ),
                        ),
                      ),
                      Obx(() => (c.dotLikeYou.value && index == 1) ||
                              (c.dotChat.value && index == 2)
                          ? Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                height: 14,
                                width: 14,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppTheme.colorBackgroundHeader,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppTheme.colorSecondary,
                                )),
                              ),
                            )
                          : const SizedBox())
                    ],
                  );
                }),
              ),
            ),
          )),
    );
  }
}
