import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../services/themes/app_theme.dart';
import 'personal.dart';

class PersonalView extends GetView<PersonalController> {
  final PersonalController c = Get.put(PersonalController());

  PersonalView({Key? key}) : super(key: key);

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
              child: SvgPicture.asset('assets/svgs/setting.svg'),
            )
          ],
        ),
      ),
      body: mBody(context),
    );
  }

  Widget mBody(context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GetBuilder<PersonalController>(
          builder: (_) => Column(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                          width: 2, color: AppTheme.colorBackground1),
                      image: c.user.avatarProvider != null
                          ? DecorationImage(
                              image: c.user.avatarProvider!, fit: BoxFit.cover)
                          : null,
                    ),
                    child: c.user.avatarProvider == null
                        ? Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            child: TextCustom(
                              c.user.fullName,
                              style: AppTheme.textStyle16
                                  .bold()
                                  .primary()
                                  .copyWith(fontSize: 50),
                              maxLine: 1,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(height: 16),
                  TextCustom(
                    c.user.fullName,
                    style: AppTheme.textStyle16.bold().copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 46),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppTheme.colorBackground1,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextCustom(
                              'list_profile'.tr,
                              style: AppTheme.textStyle16.medium(),
                            ),
                          ),
                          SvgPicture.asset('assets/svgs/next.svg')
                        ],
                      ),
                    ),
                    onTap: () => c.onClickListProfile(),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.colorBackground1,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextCustom(
                            'wallet'.tr,
                            style: AppTheme.textStyle16.medium(),
                          ),
                        ),
                        SvgPicture.asset('assets/svgs/next.svg')
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppTheme.colorBackground1,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextCustom(
                            'list_deal'.tr,
                            style: AppTheme.textStyle16.medium(),
                          ),
                        ),
                        SvgPicture.asset('assets/svgs/next.svg')
                      ],
                    ),
                  )
                ],
              )),
    );
  }
}
