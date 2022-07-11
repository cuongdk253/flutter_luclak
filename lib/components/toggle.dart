import 'package:flutter/material.dart';

class MyToggle extends StatelessWidget {
  final bool isOn;
  final Color? unSelectedColor;
  final Color? selectedColor;
  final Color? tonggleColor;
  final double size;

  const MyToggle({
    Key? key,
    this.isOn = false,
    this.unSelectedColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.tonggleColor = Colors.white,
    this.size = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size * 0.5),
          color: isOn ? selectedColor : unSelectedColor,
        ),
        width: size * 1.6,
        height: size,
        padding: EdgeInsets.only(
            right: isOn ? (size * 0.6) + 2 : 2,
            left: isOn ? 2 : (size * 0.6) + 2,
            bottom: 2,
            top: 2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size * 0.5),
            color: tonggleColor,
          ),
        ),
      ),
    );
  }
}
