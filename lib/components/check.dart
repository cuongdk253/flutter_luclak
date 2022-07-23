import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../services/themes/app_theme.dart';

class MyCheckbox extends StatelessWidget {
  final bool isChecked;
  final Color? unSelectedColor;
  final Color? selectedColor;
  final double size;
  final bool circle;

  const MyCheckbox({
    Key? key,
    this.isChecked = false,
    this.unSelectedColor,
    this.selectedColor,
    this.size = 20,
    this.circle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: !isChecked
            ? BoxDecoration(
                borderRadius:
                    BorderRadius.circular(circle ? size / 2 : size / 5),
                border: Border.all(
                  color: unSelectedColor ?? Colors.grey,
                  width: 2.0,
                ))
            : null,
        width: size,
        height: size,
        child: Container(
          decoration: BoxDecoration(
            color: isChecked
                ? selectedColor ?? AppTheme.colorSecondary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(circle ? size / 2 : size / 5),
          ),
          child: isChecked
              ? SvgPicture.asset('assets/svgs/check.svg')
              : const SizedBox(),
        ),
      ),
    );
  }
}
