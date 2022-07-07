import 'package:appchat/pages/list_chat/list_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../services/themes/app_theme.dart';
import '../like_you/like_you_view.dart';
import '../match/match_view.dart';
import '../personal/personal_view.dart';
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
        Widget _bodyContent = Container();
        if (c.tabIndex.value == 0) {
          _bodyContent = MatchesView();
        } else if (c.tabIndex.value == 1) {
          _bodyContent = LikedYouView();
        } else if (c.tabIndex.value == 2) {
          _bodyContent = ListChatView();
        } else if (c.tabIndex.value == 3) {
          _bodyContent = PersonalView();
        }

        return _bodyContent;
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
                  return Container(
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
                  );
                }),
              ),
            ),
          )),
    );
  }
}
