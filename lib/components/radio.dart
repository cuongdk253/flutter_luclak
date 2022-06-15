import 'package:flutter/material.dart';

class MyRadiobox extends StatelessWidget {
  final bool isChecked;
  final Color color;

  const MyRadiobox({
    Key? key,
    this.isChecked = false,
    this.color = Colors.white,
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
              color: color,
              width: 2.0,
            )),
        width: 18,
        height: 18,
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isChecked ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
