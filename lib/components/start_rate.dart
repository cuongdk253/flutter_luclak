import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/themes/app_theme.dart';

Widget myStarRate(double size, double rate) {
  return Row(
    children: List.generate(
      5,
      (index) => Container(
        margin: const EdgeInsets.only(right: 4),
        child: SvgPicture.asset(
          index <= rate - 1 ? 'assets/svgs/star.svg' : 'assets/svgs/star1.svg',
          height: size,
          width: size,
          color:
              index <= rate - 1 ? AppTheme.colorYellow : AppTheme.colorBorder,
        ),
      ),
    ),
  );
}
