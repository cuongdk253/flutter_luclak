import 'package:flutter/material.dart';

class MyRadiobox extends StatelessWidget {
  final bool isChecked;
  final Color unSelectedColor;
  final Color selectedColor;
  final double size;

  const MyRadiobox({
    Key? key,
    this.isChecked = false,
    this.unSelectedColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: unSelectedColor,
              width: 2.0,
            )),
        width: size,
        height: size,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isChecked ? selectedColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
