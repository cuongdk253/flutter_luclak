import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../services/themes/app_theme.dart';
import 'chat.dart';

class ChatsView extends GetView<ChatsController> {
  final ChatsController c = Get.put(ChatsController());

  ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.colorWhite,
        leading: const SizedBox(),
        centerTitle: true,
        leadingWidth: 0,
        elevation: 0,
        title: Row(
          children: [
            InkWell(
              child: SvgPicture.asset('assets/svgs/back.svg'),
              onTap: () => c.onClickBack(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: c.listChatController.myChatWith!.avatarProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextCustom(
                    c.listChatController.myChatWith!.name,
                    style: AppTheme.textStyle18.medium(),
                  )
                ],
              ),
            ),
            InkWell(
              child: SvgPicture.asset('assets/svgs/more.svg'),
            )
          ],
        ),
        bottom: PreferredSize(
          child: Container(
            color: AppTheme.colorBorder,
            height: 1.0,
          ),
          preferredSize: const Size.fromHeight(1.0),
        ),
      ),
      body: mBody(),
      bottomNavigationBar: Obx(() {
        if (c.showImageGalleryBar.value) return selectImageBar();
        return const SizedBox();
      }),
    );
  }

  Widget mBody() {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Obx(() => ListView(
                  controller: c.scrollController,
                  children: List.generate(
                    c.listChat.length,
                    (index) => c.listChat[index]['me'] == false
                        ? _question(c.listChat[index])
                        : Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.only(left: 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                _buildAnswerQuestion(c.listChat[index]),
                              ],
                            ),
                          ),
                  ),
                )),
          ),
        ),
        _chatBar(),
      ],
    );
  }

  Widget _buildAnswerQuestion(item) {
    // if (item['answer_type'] == 'vote')
    //   return _userVoteItem(item);
    // else if (item['answer_type'] == 'face_video')
    //   return _userFaceVideoItem(item);
    // else if (item['answer_type'] == 'image')
    //   return _userImageItem(item);
    // else
    return _answer(item);
  }

  Widget _question(item) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.only(right: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.colorBorder,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              item['is_first'] == true ? 12 : 2),
                          topRight: const Radius.circular(12),
                          bottomRight: const Radius.circular(12),
                          bottomLeft: const Radius.circular(2),
                        ),
                      ),
                      child: TextCustom(
                        item['content'],
                        style: AppTheme.textStyle,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _answer(item) {
    return Expanded(
      child: Wrap(
        alignment: WrapAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.colorSecondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: Radius.circular(item['is_first'] == true ? 12 : 2),
                bottomRight: const Radius.circular(2),
                bottomLeft: const Radius.circular(12),
              ),
            ),
            child: TextCustom(
              item['content'],
              style: AppTheme.textStyle.white(),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  Widget selectImageBar() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: AppTheme.boxShadow,
          color: AppTheme.colorWhite,
        ),
        height: 250,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 36,
                  margin: const EdgeInsets.all(4),
                  child: InkWell(
                    child: Icon(
                      Icons.add_a_photo,
                      color: AppTheme.colorPrimary,
                    ),
                    // style: AppTheme.buttonPrimary,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            Expanded(
              child: GetBuilder<ChatsController>(
                builder: (_) => Stack(
                  children: [
                    SingleChildScrollView(
                      controller: c.imageScrollCtrl,
                      // child: ResponsiveGridRow(
                      //   children: List.generate(c.mediaShow.length, (index) {
                      //     return ResponsiveGridCol(
                      //       xs: 3,
                      //       child: InkWell(
                      //         child: Container(
                      //           height: 100,
                      //           padding: EdgeInsets.all(1),
                      //           child: Stack(
                      //             children: [
                      //               Positioned(
                      //                 top: 0,
                      //                 left: 0,
                      //                 bottom: 0,
                      //                 right: 0,
                      //                 child: FadeInImage(
                      //                   fit: BoxFit.cover,
                      //                   placeholder:
                      //                       MemoryImage(kTransparentImage),
                      //                   image: ThumbnailProvider(
                      //                     mediumId: c.mediaShow[index].id,
                      //                     mediumType:
                      //                         c.mediaShow[index].mediumType,
                      //                     highQuality: true,
                      //                   ),
                      //                 ),
                      //               ),
                      //               c.listIndexGallery.contains(index)
                      //                   ? Container(
                      //                       height: 98,
                      //                       width: 98,
                      //                       color:
                      //                           Colors.black.withOpacity(0.2),
                      //                       child: Container(
                      //                         height: 20,
                      //                         width: 20,
                      //                         child: Icon(
                      //                           Icons.check,
                      //                           color: AppTheme.colorBlue,
                      //                           size: 30,
                      //                         ),
                      //                       ),
                      //                     )
                      //                   : Container()
                      //             ],
                      //           ),
                      //         ),
                      //         onTap: () => c.onClickGalleryItem(index),
                      //       ),
                      //     );
                      //   }),
                      // ),
                    ),
                    // c.listIndexGallery.length > 0
                    //     ? Positioned(
                    //         bottom: 16,
                    //         right: 16,
                    //         child: InkWell(
                    //           child: Container(
                    //             height: 40,
                    //             width: 80,
                    //             alignment: Alignment.center,
                    //             decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(16),
                    //                 color:
                    //                     AppTheme.colorWhite.withOpacity(0.9)),
                    //             // child: Icon(
                    //             //   Icons.send,
                    //             //   color: AppTheme.colorBlue,
                    //             // ),
                    //             child: TextCustom(
                    //               'Gửi',
                    //               style: AppTheme.textStyle16.blue().bold(),
                    //             ),
                    //           ),
                    //           onTap: () => c.onClickSendImage(),
                    //         ),
                    //       )
                    //     : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _chatBar() {
    TextEditingController _text = TextEditingController();
    return SafeArea(
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 16, right: 4),
        // decoration: BoxDecoration(
        color: AppTheme.colorWhite,
        //   boxShadow: AppTheme.boxShadow,
        // ),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 36,
                child: TextFormField(
                  controller: _text,
                  style: AppTheme.textStyle,
                  autofocus: true,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colorBorder),
                        borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colorBorder),
                        borderRadius: BorderRadius.circular(16)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.colorBorder),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme.colorBackground),
                child: SvgPicture.asset(
                  'assets/svgs/send.svg',
                  color: AppTheme.colorPrimary,
                ),
              ),
              onTap: () {
                c.onClickChatSend(_text.text);
                _text.text = '';
              },
            )
          ],
        ),
      ),
    );
  }
}
