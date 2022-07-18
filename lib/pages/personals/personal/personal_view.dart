import 'package:appchat/components/image_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/text.dart';
import '../../../services/themes/app_theme.dart';
import '../../header_bar/header_bar_view.dart';
import 'personal.dart';

class PersonalView extends GetView<PersonalController> {
  final PersonalController c = Get.put(PersonalController());

  PersonalView({Key? key}) : super(key: key);

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
          children: [
            const SizedBox(height: 30),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 3, color: AppTheme.colorGreyText),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: AppTheme.colorPrimary,
                      image: c.user.avatarUrl != ''
                          ? myImageDecoration(c.user.avatarUrl)
                          : null,
                    ),
                    child: c.user.avatarUrl == ''
                        ? TextCustom(
                            c.user.fullName,
                            style: AppTheme.textStyle16
                                .bold()
                                .copyWith(fontSize: 50),
                            maxLine: 1,
                            textAlign: TextAlign.center,
                          )
                        : const SizedBox(),
                  ),
                ),
                Container(
                  height: 150,
                  width: 150,
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.all(1),
                  child: const CircularProgressIndicator(
                    strokeWidth: 4,
                    value: 0.25,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 24,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: AppTheme.gradient,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextCustom(
                      '25% ${'complete'.tr}',
                      style: AppTheme.textStyleSub,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextCustom(
              '${c.user.fullName}, ${c.user.age.toString()}',
              style: AppTheme.textStyle16.bold().copyWith(fontSize: 22),
            ),
            const SizedBox(height: 32),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SizedBox(
                  width: Get.width,
                  height: 125,
                ),
                Positioned(
                  left: 24,
                  child: InkWell(
                    child: SizedBox(
                      width: 100,
                      child: Column(children: [
                        Container(
                          height: 48,
                          width: 48,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0.0, 2.0),
                                color: Colors.black.withOpacity(.5),
                                blurRadius: 10.0,
                              ),
                            ],
                            color: AppTheme.colorBackgroundCard,
                          ),
                          child: SvgPicture.asset('assets/svgs/shield.svg'),
                        ),
                        const SizedBox(height: 8),
                        TextCustom(
                          'SAFE'.tr,
                          style: AppTheme.textStyle16.bold().grey(),
                        )
                      ]),
                    ),
                    onTap: () => c.onClickSafe(),
                  ),
                ),
                Positioned(
                  right: 16,
                  child: InkWell(
                    child: SizedBox(
                      width: 100,
                      child: Column(children: [
                        Container(
                          height: 48,
                          width: 48,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0.0, 2.0),
                                color: Colors.black.withOpacity(.5),
                                blurRadius: 10.0,
                              ),
                            ],
                            color: AppTheme.colorBackgroundCard,
                          ),
                          child: SvgPicture.asset('assets/svgs/setting1.svg'),
                        ),
                        const SizedBox(height: 8),
                        TextCustom(
                          'SETTING'.tr,
                          style: AppTheme.textStyle16.bold().grey(),
                        )
                      ]),
                    ),
                    onTap: () => c.onClickSetting(),
                  ),
                ),
                Positioned(
                  top: 20,
                  child: InkWell(
                    child: SizedBox(
                      child: Column(children: [
                        Container(
                          height: 75,
                          width: 75,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0.0, 2.0),
                                color: Colors.black.withOpacity(.5),
                                blurRadius: 10.0,
                              ),
                            ],
                            color: AppTheme.colorBackgroundCard,
                          ),
                          child: SvgPicture.asset('assets/svgs/edit.svg'),
                        ),
                        const SizedBox(height: 8),
                        TextCustom(
                          'EDIT_PROFILE'.tr,
                          style: AppTheme.textStyle16.bold().grey(),
                        )
                      ]),
                    ),
                    onTap: () => c.onClickEditProfile(),
                  ),
                ),
              ],
            )
          ],
        ),
        Positioned(
          bottom: 0,
          child: _adApp(),
        ),
      ],
    );
  }

  Widget _adApp() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      color: AppTheme.colorBackgroundCard,
      child: Column(
        children: [
          TextCustom(
            'upgrade_full'.tr,
            style: AppTheme.textStyle16.bold(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextCustom(
            'unlock_function'.tr,
            style: AppTheme.textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          InkWell(
            child: Container(
              height: 44,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: AppTheme.gradient),
              child: TextCustom(
                'view_all_package'.tr,
                style: AppTheme.textStyle18.bold().white(),
              ),
            ),
            // onTap: () => c.onClickNext(),
          )
        ],
      ),
    );
  }
}
