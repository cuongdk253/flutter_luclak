import 'package:flutter/material.dart';

import 'text_style.dart';

class AppTheme {
  AppTheme._();

  static final Color colorText = HexColor('#FFFFFF');
  static final Color colorTextDark = HexColor('#333333');
  static final Color colorGreyText = HexColor('#A1A1A1');
  static final Color colorGreyText1 = HexColor('#555555');

  static final Color colorBorderLine = HexColor('#F2F2F2');
  static final Color colorBackground = HexColor('#F5F5F5');
  static final Color colorBackgroundDark = HexColor('#292929');
  static final Color colorBackgroundHeader = HexColor('#1A1A1A');
  static final Color colorBackgroundCard = HexColor('#343434');
  static final Color colorBackground1 = HexColor('#FDF8EE');

  static final Color colorBlue = HexColor('#0B7EFB');

  static final Color colorPrimary = HexColor('#8946A6');
  static final Color colorSecondary = HexColor('#FC5C7D');
  static final Color colorAccent = HexColor('#E67817');
  static final Color colorRed = HexColor('#F23053');
  static final Color colorWhite = HexColor('#FFFFFF');
  static final Color colorYellow = HexColor('#F5CA2F');
  static final Color colorGreen = HexColor('#339C44');

  static final Color colorDisable = HexColor('#E3E3E3');
  static final Color colorBorder = HexColor('#E5E5E5');

  static const double fontSize16 = 16;
  static const double fontSize18 = 18;
  static const double fontSize14 = 14;
  static const double fontSize12 = 12;
  static const double fontSize20 = 20;

  static final Border borderBottomLine = Border(
    bottom: BorderSide(
      width: 0.5,
      color: colorBorderLine,
    ),
  );

  static final gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      AppTheme.colorSecondary,
      HexColor('#BA4F95'),
      AppTheme.colorPrimary,
    ],
    stops: const [0.0, 0.35, 1.0],
    tileMode: TileMode.mirror,
  );

  static final Border borderTopLine = Border(
    top: BorderSide(
      width: 1,
      color: colorBorderLine,
    ),
  );

  static final TextStyle headerTitle = TextStyle(
    // text on header
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: colorWhite,
  );

  static final MyTextStyle textStyle = MyTextStyle(
    fontSize: fontSize14,
    color: colorText,
    fontWeight: FontWeight.w400,
  );

  static final MyTextStyle textStyle16 = MyTextStyle(
    fontSize: fontSize16,
    color: colorText,
    fontWeight: FontWeight.w400,
  );

  static final MyTextStyle textStyle18 = MyTextStyle(
    fontSize: fontSize18,
    color: colorText,
    fontWeight: FontWeight.w400,
  );

  static final MyTextStyle textStyle20 = MyTextStyle(
    fontSize: fontSize20,
    color: colorText,
    fontWeight: FontWeight.w400,
  );

  static final MyTextStyle textStyleSub = MyTextStyle(
    fontSize: fontSize12,
    color: colorText,
    fontWeight: FontWeight.w400,
  );

  //style font chữ lỗi validate
  static final TextStyle textErrorValidateStyle = TextStyle(
    fontSize: fontSize12,
    color: colorBorder,
  );

  static final TextStyle textStyleBig = TextStyle(
    fontSize: fontSize18,
    color: colorText,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle textStyleDark = TextStyle(
    fontSize: fontSize16,
    color: colorText,
  );

  static final TextStyle btnTextStyle = TextStyle(
    fontSize: fontSize16,
    color: colorBlue,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textBtnLight = TextStyle(
    fontSize: fontSize16,
    color: Colors.white,
  );

  static final TextStyle textBtnBlue = TextStyle(
    fontSize: fontSize16,
    color: colorBlue,
  );

  static final TextStyle borderRadius = TextStyle(
    fontSize: fontSize16,
    color: colorBorder,
  );

  static final boxShadow = [
    BoxShadow(
      offset: const Offset(0.0, -1.0),
      color: Colors.black.withOpacity(.2),
      blurRadius: 5.0,
    ),
  ];

  static final OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colorBorderLine),
      borderRadius: BorderRadius.circular(8));

  static final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.black87,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.0)),
    ),
  );

  static final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  static final TextStyle textSmall = TextStyle(
    fontSize: 14,
    color: colorBlue,
  );

  static final TextStyle textMedium = TextStyle(
    fontSize: fontSize16,
    color: colorText,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle textLarge = TextStyle(
    fontSize: 18,
    color: colorBlue,
  );

  //style button chính, nền xanh
  static final ButtonStyle buttonPrimary = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    overlayColor: MaterialStateProperty.all<Color>(
        const Color.fromRGBO(255, 255, 255, 0.45)),
  );

  //style button phụ, nền xanh nhạt, text xanh
  static final ButtonStyle buttonSecondary = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(colorSecondary),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
    overlayColor: MaterialStateProperty.all<Color>(
        const Color.fromRGBO(255, 255, 255, 0.45)),
  );

  static final ButtonStyle roundOulineButton = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppTheme.colorBorderLine),
      ),
    ),
    padding: MaterialStateProperty.all(EdgeInsets.zero),
  );
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
