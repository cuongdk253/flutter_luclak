import 'package:flutter/material.dart';
import 'dart:ui' as ui show Shadow, FontFeature;

import 'app_theme.dart';

@immutable
class MyTextStyle extends TextStyle {
  MyTextStyle bold() {
    return copyWith1(fontWeight: FontWeight.w700);
  }

  MyTextStyle medium() {
    return copyWith1(fontWeight: FontWeight.w500);
  }

  MyTextStyle grey() {
    return copyWith1(
      color: AppTheme.colorGreyText,
    );
  }

  MyTextStyle green() {
    return copyWith1(
      color: AppTheme.colorGreen,
    );
  }

  MyTextStyle white() {
    return copyWith1(
      color: AppTheme.colorWhite,
    );
  }

  MyTextStyle accent() {
    return copyWith1(
      color: AppTheme.colorAccent,
    );
  }

  MyTextStyle red() {
    return copyWith1(
      color: AppTheme.colorRed,
    );
  }

  MyTextStyle primary() {
    return copyWith1(
      color: AppTheme.colorPrimary,
    );
  }

  MyTextStyle blue() {
    return copyWith1(
      color: AppTheme.colorBlue,
    );
  }

  MyTextStyle secondary() {
    return copyWith1(
      color: AppTheme.colorSecondary,
    );
  }

  MyTextStyle copyWith1({
    bool? inherit,
    Color? color,
    Color? backgroundColor,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<ui.Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
  }) {
    assert(color == null || foreground == null);
    assert(backgroundColor == null || background == null);
    String? newDebugLabel;
    assert(() {
      if (this.debugLabel != null) {
        newDebugLabel = debugLabel ?? '(${this.debugLabel}).copyWith1';
      }
      return true;
    }());
    return MyTextStyle(
      inherit: inherit ?? this.inherit,
      color: this.foreground == null && foreground == null
          ? color ?? this.color
          : null,
      backgroundColor: this.background == null && background == null
          ? backgroundColor ?? this.backgroundColor
          : null,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      shadows: shadows ?? this.shadows,
      fontFeatures: fontFeatures ?? this.fontFeatures,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
      debugLabel: newDebugLabel,
    );
  }

  const MyTextStyle({
    inherit = true,
    fontSize,
    color,
    fontWeight,
    backgroundColor,
    fontFamily,
    fontFamilyFallback,
    fontStyle,
    letterSpacing,
    wordSpacing,
    textBaseline,
    height,
    locale,
    foreground,
    background,
    shadows,
    fontFeatures,
    decoration,
    decorationColor,
    decorationStyle,
    decorationThickness,
    debugLabel,
  }) : super(
          inherit: inherit,
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          backgroundColor: backgroundColor,
          fontFamily: fontFamily,
          fontFamilyFallback: fontFamilyFallback,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          locale: locale,
          foreground: foreground,
          background: background,
          shadows: shadows,
          fontFeatures: fontFeatures,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          debugLabel: debugLabel,
        );
}
