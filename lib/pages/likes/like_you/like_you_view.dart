import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/image_decoration.dart';
import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import '../../header_bar/header_bar_view.dart';
import 'like_you.dart';

class LikedYouView extends GetView<LikedYouController> {
  final LikedYouController c = Get.put(LikedYouController());

  LikedYouView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackgroundHeader,
      appBar: HeaderBarView(),
      body: mBody(context),
    );
  }

  Widget mBody(context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                TextCustom(
                  'like_you'.tr,
                  style: AppTheme.textStyle.copyWith(fontSize: 30),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: TextCustom(
                    'des_like_you'.tr,
                    style: AppTheme.textStyle16.medium(),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 2,
                  width: Get.width,
                  color: AppTheme.colorGreyText,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Obx(() => Row(
                        children: [
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: !c.youLike.value
                                    ? AppTheme.colorPrimary
                                    : Colors.transparent,
                              ),
                              child: TextCustom(
                                'like_you'.tr,
                                style: AppTheme.textStyle16.medium(),
                              ),
                            ),
                            onTap: () => c.onClickTab(false),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: c.youLike.value
                                    ? AppTheme.colorPrimary
                                    : Colors.transparent,
                              ),
                              child: TextCustom(
                                'you_liked'.tr,
                                style: AppTheme.textStyle16,
                              ),
                            ),
                            onTap: () => c.onClickTab(true),
                          )
                        ],
                      )),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() => Wrap(
                      children: List.generate(
                        c.listData.length,
                        (index) => _item(index),
                      ),
                    )),
              ),
            )
          ],
        ),
        Positioned(
          bottom: 16,
          right: 32,
          left: 32,
          child: InkWell(
            child: Container(
              height: 44,
              width: Get.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: AppTheme.gradient),
              child: TextCustom(
                'see_who_like_you'.tr,
                style: AppTheme.textStyle18.bold().white(),
              ),
            ),
            onTap: () => c.onClickSeeWhoLikeYou(),
          ),
        )
      ],
    );
  }

  Widget _item(index) {
    var _item = c.listData[index];
    bool blur = _item['me'] == false;

    return Container(
      margin: const EdgeInsets.all(8),
      height: ((Get.width - 48) / 2) * 1.2,
      width: (Get.width - 48) / 2,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: myImageDecoration(
                  blur ? _item['profile_image'] : _item['profile_image_liked']),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.8, 1.0],
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 8,
            child: TextCustom(
                blur ? _item['user_name'] : _item['user_name_liked']),
          ),
          blur
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: SizedBox(
                      height: ((Get.width - 48) / 2) * 1.2,
                      width: (Get.width - 48) / 2,
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
