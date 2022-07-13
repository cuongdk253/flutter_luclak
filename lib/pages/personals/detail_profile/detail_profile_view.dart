import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/http/cmd.dart';
import '../../../services/themes/app_theme.dart';
import 'detail_profile.dart';

class DetailProfileView extends GetView<DetailProfileController> {
  final DetailProfileController c = Get.put(DetailProfileController());

  DetailProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackgroundDark,
      appBar: mAppBar(),
      body: mBody(),
    );
  }

  Widget mBody() {
    return ListView(
      children: [
        _photo(),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                'introduce'.tr,
                style: AppTheme.textStyle18.bold(),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorBackgroundCard,
                ),
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: c.aboutYou,
                  style: AppTheme.textStyle18.medium(),
                  maxLines: 3,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                    filled: true,
                    fillColor: AppTheme.colorBackgroundCard,
                    hintText: 'add_your_description'.tr,
                    hintStyle: AppTheme.textStyle18.medium().grey(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                'power'.tr,
                style: AppTheme.textStyle18.bold(),
              ),
              const SizedBox(height: 8),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppTheme.colorBackgroundCard,
                  ),
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.center,
                  child: Row(children: [
                    Expanded(
                      child: Obx(() => TextCustom(
                            c.power.value,
                            style: AppTheme.textStyle16,
                          )),
                    ),
                    SvgPicture.asset(
                      'assets/svgs/next.svg',
                      color: AppTheme.colorText,
                    )
                  ]),
                ),
                onTap: () => c.onClickPowerCard(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                'Facebook',
                style: AppTheme.textStyle18.bold(),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorBackgroundCard,
                ),
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Row(children: [
                  Expanded(
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SvgPicture.asset(
                          'assets/svgs/logo_facebook.svg',
                          color: AppTheme.colorText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextCustom(
                        '${'connect'.tr} Facebook',
                        style: AppTheme.textStyle16,
                      )
                    ]),
                  ),
                  TextCustom(
                    'connect'.tr,
                    style: AppTheme.textStyle16.secondary(),
                  )
                ]),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                'Instagram',
                style: AppTheme.textStyle18.bold(),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorBackgroundCard,
                ),
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Row(children: [
                  Expanded(
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SvgPicture.asset(
                          'assets/svgs/logo_instagram.svg',
                          color: AppTheme.colorText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextCustom(
                        '${'connect'.tr} Instagram',
                        style: AppTheme.textStyle16,
                      )
                    ]),
                  ),
                  TextCustom(
                    'connect'.tr,
                    style: AppTheme.textStyle16.secondary(),
                  )
                ]),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextCustom(
                'Tiktok',
                style: AppTheme.textStyle18.bold(),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppTheme.colorBackgroundCard,
                ),
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Row(children: [
                  Expanded(
                    child: Row(children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: SvgPicture.asset(
                          'assets/svgs/logo_tiktok.svg',
                          color: AppTheme.colorText,
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextCustom(
                        '${'connect'.tr} Tiktok',
                        style: AppTheme.textStyle16,
                      )
                    ]),
                  ),
                  TextCustom(
                    'connect'.tr,
                    style: AppTheme.textStyle16.secondary(),
                  )
                ]),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }

  AppBar mAppBar() {
    return AppBar(
      backgroundColor: AppTheme.colorBackgroundHeader,
      leading: const SizedBox(),
      centerTitle: true,
      leadingWidth: 0,
      elevation: 0,
      title: Row(
        children: [
          InkWell(
            child: SvgPicture.asset(
              'assets/svgs/back.svg',
              color: AppTheme.colorText,
            ),
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
              style: AppTheme.textStyle16.bold().secondary(),
            ),
            onTap: () => c.onClickDone(),
          )
        ],
      ),
      bottom: PreferredSize(
        child: Container(
          color: AppTheme.colorGreyText1,
          height: 1.0,
        ),
        preferredSize: const Size.fromHeight(1.0),
      ),
    );
  }

  Widget _photo() {
    return GetBuilder<DetailProfileController>(
        builder: (_) => Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: List.generate(
                      c.listImage.length,
                      (index) => InkWell(
                        child: _imageItem(c.listImage[index]),
                        onTap: () => c.onClickImage(index),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  _imageItem(item) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          width: (Get.width - 24) / 3,
          height: (Get.width - 24) / 3 * 1.4,
          child: Container(
            width: (Get.width - 24) / 3,
            height: (Get.width - 24) / 3 * 1.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppTheme.colorBackgroundCard,
                image: item['image_url'] != ''
                    ? DecorationImage(
                        image: NetworkImage(baseUrl + item['image_url']),
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: item['image_url'] != ''
                  ? AppTheme.colorBackgroundCard
                  : AppTheme.colorGreyText,
              boxShadow: AppTheme.boxShadow,
            ),
            child: SvgPicture.asset(
              item['image_url'] != ''
                  ? 'assets/svgs/close.svg'
                  : 'assets/svgs/plus.svg',
              color: AppTheme.colorText,
            ),
          ),
        ),
        Obx(
          () => item['uploading'].value == true
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: (Get.width - 24) / 3,
                      height: (Get.width - 24) / 3 * 1.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        backgroundColor: AppTheme.colorWhite.withOpacity(0.3),
                        color: AppTheme.colorPrimary,
                        value: item['process'].value,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
