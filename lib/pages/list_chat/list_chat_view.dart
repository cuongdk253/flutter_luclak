import 'dart:ui';

import 'package:appchat/components/image_decoration.dart';
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
      backgroundColor: AppTheme.colorBackgroundHeader,
      appBar: AppBar(
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
      ),
      body: mBody(context),
    );
  }

  Widget mBody(context) {
    return Column(
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
              Obx(() => c.listData.isNotEmpty
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
                              imageUrl: c.listData[0]['profile_image'],
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
                              imageUrl: c.listData[1]['profile_image'],
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
                                '5',
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
                  : const SizedBox()),
              const SizedBox(width: 16),
              Obx(() => Row(
                    children: List.generate(
                      c.listData.length,
                      (index) => Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                right: 12, top: 4, bottom: 4),
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
                                  image: myImageDecoration(
                                      c.listData[index]['profile_image']),
                                  borderRadius: BorderRadius.circular(40)),
                            ),
                          ),
                          Container(
                            height: 78,
                            width: 78,
                            margin: const EdgeInsets.all(1),
                            child: const CircularProgressIndicator(
                              strokeWidth: 6,
                              value: 0.8,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.purple),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
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
        Expanded(
          child: SingleChildScrollView(
            child: Obx(() => Column(
                  children: List.generate(
                    c.listData.length,
                    (index) => Container(
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
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  width: 2.5,
                                  color: AppTheme.colorGreyText,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: myImageDecoration(
                                        c.listData[index]['profile_image']),
                                    borderRadius: BorderRadius.circular(40)),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 80,
                              padding: const EdgeInsets.all(1),
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.5,
                                value: 0.8,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.purple),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextCustom(
                                    c.listData[index]['user_name'],
                                    style: AppTheme.textStyle18.bold(),
                                  ),
                                  TextCustom(
                                    c.listData[index]['user_name'],
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
                                        '5 ${'hours'.tr}',
                                        style: AppTheme.textStyleSub.yellow(),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: AppTheme.colorPrimary,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: TextCustom(
                                    'your_move'.tr,
                                    style: AppTheme.textStyleSub,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                )),
          ),
        )
      ],
    );
  }

  Widget _blurImage({
    required double height,
    required double width,
    required String imageUrl,
  }) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: myImageDecoration(imageUrl),
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

  // Widget mBody(context) {
  //   return GetBuilder<ListChatController>(
  //       builder: (_) => ListView(
  //             children: List.generate(
  //               c.listUserChat.length,
  //               (index) => InkWell(
  //                 child: Container(
  //                   padding:
  //                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //                   decoration:
  //                       BoxDecoration(border: AppTheme.borderBottomLine),
  //                   child: Row(children: [
  //                     SizedBox(
  //                       height: 60,
  //                       width: 60,
  //                       child: Container(
  //                         padding: const EdgeInsets.only(top: 42, left: 42),
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(30),
  //                           // image: DecorationImage(
  //                           //   image: c.listUserChat[index].avatarProvider,
  //                           //   fit: BoxFit.cover,
  //                           // ),
  //                         ),
  //                         child: !c.listUserChat[index].read
  //                             ? Container(
  //                                 height: 10,
  //                                 width: 10,
  //                                 padding: const EdgeInsets.all(3),
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   color: AppTheme.colorWhite,
  //                                 ),
  //                                 child: Container(
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(10),
  //                                     color: AppTheme.colorSecondary,
  //                                   ),
  //                                 ),
  //                               )
  //                             : const SizedBox(),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 24),
  //                     Expanded(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           TextCustom(
  //                             c.listUserChat[index].name,
  //                             style: AppTheme.textStyle16.medium(),
  //                             maxLine: 1,
  //                             textOverflow: TextOverflow.ellipsis,
  //                           ),
  //                           TextCustom(
  //                             c.listUserChat[index].content,
  //                             style: AppTheme.textStyle,
  //                             maxLine: 1,
  //                             textOverflow: TextOverflow.ellipsis,
  //                           ),
  //                           const SizedBox(height: 2),
  //                           TextCustom(
  //                             'BFF',
  //                             style: AppTheme.textStyle.blue().medium(),
  //                             maxLine: 1,
  //                             textOverflow: TextOverflow.ellipsis,
  //                           ),
  //                         ],
  //                       ),
  //                     )
  //                   ]),
  //                 ),
  //                 onTap: () => c.onClickItem(index),
  //               ),
  //             ),
  //           ));
  // }
}
