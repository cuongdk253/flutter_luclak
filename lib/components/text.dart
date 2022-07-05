import 'package:flutter/material.dart';

import '../services/themes/app_theme.dart';

//** Component về text và các tuỳ chỉnh */
class TextCustom extends StatelessWidget {
  final String title;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final double fontSize;
  final TextOverflow? textOverflow;
  final TextAlign textAlign;
  final int? maxLine;
  final TextStyle? style;
  const TextCustom(this.title,
      {Key? key,
      this.color = Colors.blueGrey,
      this.fontWeight = FontWeight.normal,
      this.fontSize = 14,
      this.textOverflow,
      this.textAlign = TextAlign.left,
      this.fontStyle,
      this.style,
      this.maxLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: style ?? AppTheme.textStyleDark,
      overflow: textOverflow,
      maxLines: maxLine,
    );
  }
}
