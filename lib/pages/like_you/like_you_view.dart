import 'dart:ui';

import 'package:appchat/services/http/cmd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../services/themes/app_theme.dart';
import 'like_you.dart';

class LikedYouView extends GetView<LikedYouController> {
  final LikedYouController c = Get.put(LikedYouController());

  LikedYouView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.colorPrimary,
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
                color: AppTheme.colorWhite,
              ),
            ),
            TextCustom(
              'like_you'.tr,
              style: AppTheme.textStyle18.white().medium(),
            ),
            InkWell(
              child: SvgPicture.asset(
                'assets/svgs/sort.svg',
                color: AppTheme.colorWhite,
              ),
            )
          ],
        ),
      ),
      body: mBody(context),
    );
  }

  Widget mBody(context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: Get.width,
          color: AppTheme.colorPrimary,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: Get.height,
            width: Get.width,
            color: AppTheme.colorWhite,
            padding: const EdgeInsets.all(6),
            child: Obx(() => Wrap(
                  children: List.generate(
                    c.listData.length,
                    (index) => Container(
                      margin: const EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(children: [
                          Container(
                            height: Get.width * 0.6,
                            width: (Get.width - 36) / 2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      baseUrl + c.listData[index]['avatar']),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            height: Get.width * 0.6,
                            width: (Get.width - 36) / 2,
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
                            bottom: 8,
                            left: 8,
                            child: TextCustom(
                              c.listData[index]['name'],
                              style: AppTheme.textStyle16.medium().white(),
                            ),
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                            child: Container(
                              height: Get.width * 0.6,
                              width: (Get.width - 36) / 2,
                              color: Colors.grey.withOpacity(0.1),
                              alignment: Alignment.center,
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 8,
                            child: Container(
                              width: c.listData[index]['name'].length.toDouble() * 9.0,
                              height: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppTheme.colorWhite,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
