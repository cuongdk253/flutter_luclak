import 'package:appchat/services/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCheckbox extends StatelessWidget {
  final bool isChecked;
  final Color? unSelectedColor;
  final Color? selectedColor;
  final double size;

  const MyCheckbox({
    Key? key,
    this.isChecked = false,
    this.unSelectedColor,
    this.selectedColor,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: !isChecked
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
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
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SvgPicture.asset('assets/svgs/check.svg'),
        ),
      ),
    );
  }
}
