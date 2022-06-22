import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/text.dart';
import '../../services/themes/app_theme.dart';
import 'list_profile.dart';

class ListProfileView extends GetView<ListProfileController> {
  final ListProfileController c = Get.put(ListProfileController());

  ListProfileView({Key? key}) : super(key: key);

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
                'list_profile'.tr,
                style: AppTheme.textStyle18.medium(),
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              child: SvgPicture.asset('assets/svgs/plus.svg'),
              onTap: () => c.onClickAddProfile(),
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
    return const SizedBox();
  }
}
