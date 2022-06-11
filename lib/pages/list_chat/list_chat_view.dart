import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../services/themes/app_theme.dart';
import 'list_chat.dart';

class ListChatView extends GetView<ListChatController> {
  final ListChatController c = Get.put(ListChatController());

  ListChatView({Key? key}) : super(key: key);

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
            InkWell(
              child: SvgPicture.asset('assets/svgs/search.svg'),
            )
          ],
        ),
        bottom: PreferredSize(
          child: Container(
            color: AppTheme.colorBorder,
            height: 3.0,
          ),
          preferredSize: const Size.fromHeight(3.0),
        ),
      ),
      body: mBody(context),
    );
  }

  Widget mBody(context) {
    return GetBuilder<ListChatController>(
        builder: (_) => ListView(
              children: List.generate(
                c.listUserChat.length,
                (index) => InkWell(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration:
                        BoxDecoration(border: AppTheme.borderBottomLine),
                    child: Row(children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: Container(
                          padding: const EdgeInsets.only(top: 42, left: 42),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: c.listUserChat[index].avatarProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: !c.listUserChat[index].read
                              ? Container(
                                  height: 10,
                                  width: 10,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppTheme.colorWhite,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppTheme.colorSecondary,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(
                              c.listUserChat[index].name,
                              style: AppTheme.textStyle16.medium(),
                              maxLine: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            TextCustom(
                              c.listUserChat[index].content,
                              style: AppTheme.textStyle,
                              maxLine: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            TextCustom(
                              'BFF',
                              style: AppTheme.textStyle.blue().medium(),
                              maxLine: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                  onTap: () => c.onClickItem(index),
                ),
              ),
            ));
  }
}
