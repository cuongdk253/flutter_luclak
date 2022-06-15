import 'package:appchat/services/http/cmd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../services/themes/app_theme.dart';
import 'detail_profile.dart';

class DetailProfileView extends GetView<DetailProfileController> {
  final DetailProfileController c = Get.put(DetailProfileController());

  DetailProfileView({Key? key}) : super(key: key);

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
              child: TextCustom(
                'add_profile'.tr,
                style: AppTheme.textStyle18.medium(),
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              child: TextCustom(
                'done'.tr,
                style: AppTheme.textStyle16.bold().primary(),
              ),
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
    );
  }

  Widget mBody() {
    return ListView(
      children: [
        _photo(),
      ],
    );
  }

  Widget _photo() {
    return GetBuilder<DetailProfileController>(
        builder: (_) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    'my_photo'.tr,
                    style: AppTheme.textStyle18.bold(),
                  ),
                  const SizedBox(height: 8),
                  TextCustom(
                    'my_photo_sub'.tr,
                    style: AppTheme.textStyle16.grey(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      InkWell(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: ((Get.width - 48) / 3) * 2 + 8,
                              height: Get.width * 0.64,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppTheme.colorBackground),
                                  color: AppTheme.colorBackground,
                                  image: c.listImage[0]['image_url'] != ''
                                      ? DecorationImage(
                                          image: NetworkImage(baseUrl +
                                              c.listImage[0]['image_url']),
                                          fit: BoxFit.cover,
                                        )
                                      : null),
                            ),
                            Positioned(
                              left: 8,
                              bottom: 8,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.15)),
                                  child: TextCustom(
                                    'main_photo'.tr,
                                    style: AppTheme.textStyle
                                        .white()
                                        .copyWith(fontSize: 10),
                                  )),
                            ),
                            Obx(
                              () => c.listImage[0]['uploading'].value == true
                                  ? Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          width: ((Get.width - 48) / 3) * 2 + 8,
                                          height: Get.width * 0.64,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: CircularProgressIndicator(
                                            backgroundColor: AppTheme.colorWhite
                                                .withOpacity(0.3),
                                            color: AppTheme.colorPrimary,
                                            value:
                                                c.listImage[0]['process'].value,
                                          ),
                                        ),
                                      ],
                                    )
                                  : c.listImage[0]['image_url'] == ''
                                      ? Center(
                                          child: SvgPicture.asset(
                                            'assets/svgs/plus.svg',
                                            color: AppTheme.colorGreyText,
                                          ),
                                        )
                                      : const SizedBox(),
                            ),
                          ],
                        ),
                        onTap: () => c.onClickImage(0),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        children: List.generate(
                          2,
                          (index) => InkWell(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: index != 0 ? 4 : 0,
                                      bottom: index != 1 ? 4 : 0),
                                  width: ((Get.width - 48) / 3),
                                  height: Get.width * 0.32 - 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppTheme.colorBackground),
                                      color: AppTheme.colorBackground,
                                      image: c.listImage[index + 1]
                                                  ['image_url'] !=
                                              ''
                                          ? DecorationImage(
                                              image: NetworkImage(baseUrl +
                                                  c.listImage[index + 1]
                                                      ['image_url']),
                                              fit: BoxFit.cover,
                                            )
                                          : null),
                                ),
                                Positioned(
                                  left: 8,
                                  bottom: 8,
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Colors.black.withOpacity(0.15)),
                                      child: TextCustom(
                                        (index + 2).toString(),
                                        style: AppTheme.textStyle
                                            .white()
                                            .copyWith(fontSize: 10),
                                      )),
                                ),
                                Obx(
                                  () => c.listImage[index + 1]['uploading']
                                              .value ==
                                          true
                                      ? Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            Container(
                                              width: ((Get.width - 48) / 3),
                                              height: Get.width * 0.32 - 4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator(
                                                backgroundColor: AppTheme
                                                    .colorWhite
                                                    .withOpacity(0.3),
                                                color: AppTheme.colorPrimary,
                                                value: c
                                                    .listImage[index + 1]
                                                        ['process']
                                                    .value,
                                              ),
                                            ),
                                          ],
                                        )
                                      : c.listImage[index + 1]['image_url'] ==
                                              ''
                                          ? Center(
                                              child: SvgPicture.asset(
                                                'assets/svgs/plus.svg',
                                                color: AppTheme.colorGreyText,
                                              ),
                                            )
                                          : const SizedBox(),
                                ),
                              ],
                            ),
                            onTap: () => c.onClickImage(index + 1),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      3,
                      (index) => InkWell(
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: index != 0 ? 4 : 0,
                                  right: index != 2 ? 4 : 0),
                              width: ((Get.width - 48) / 3),
                              height: Get.width * 0.32 - 4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: AppTheme.colorBackground),
                                  color: AppTheme.colorBackground,
                                  image:
                                      c.listImage[index + 3]['image_url'] != ''
                                          ? DecorationImage(
                                              image: NetworkImage(baseUrl +
                                                  c.listImage[index + 3]
                                                      ['image_url']),
                                              fit: BoxFit.cover,
                                            )
                                          : null),
                            ),
                            Positioned(
                              left: 8,
                              bottom: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(0.15)),
                                child: TextCustom(
                                  (index + 4).toString(),
                                  style: AppTheme.textStyle
                                      .white()
                                      .copyWith(fontSize: 10),
                                ),
                              ),
                            ),
                            Obx(
                              () => c.listImage[index + 3]['uploading'].value ==
                                      true
                                  ? Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                          width: ((Get.width - 48) / 3),
                                          height: Get.width * 0.32 - 4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: CircularProgressIndicator(
                                            backgroundColor: AppTheme.colorWhite
                                                .withOpacity(0.3),
                                            color: AppTheme.colorPrimary,
                                            value: c
                                                .listImage[index + 3]['process']
                                                .value,
                                          ),
                                        ),
                                      ],
                                    )
                                  : c.listImage[index + 3]['image_url'] == ''
                                      ? Center(
                                          child: SvgPicture.asset(
                                            'assets/svgs/plus.svg',
                                            color: AppTheme.colorGreyText,
                                          ),
                                        )
                                      : const SizedBox(),
                            ),
                          ],
                        ),
                        onTap: () => c.onClickImage(index + 3),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
