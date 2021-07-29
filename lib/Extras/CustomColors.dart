import 'dart:ui';

import 'package:flutter/material.dart';

class CColors{

  static const primary = Color(0xFF0EA102);
  static const lightgreen = Color(0xFF7EBA00);
  static const yellowd = Color(0xFFF7931A);
  static const blue = Color(0xFF4062F9);
  static const graphpurple = Color(0xFF661A72);
  static const graphblue = Color(0xFF044F79);
  static const gray = Color(0xFFA5A5A5);
  static const offwhite = Color(0xFFfbfbfb);
  static const whitebg = Color(0xFFFDFDFD);
  static const whitebg2 = Color(0xFF9F9F9F);
  static const graytext = Color(0xFFB0B0B0);
  static const graytexthalf = Color(0x80B0B0B0);
  static const stroke = Color(0xFFF8F8F8);

  static const textblack1 = Color(0xBf000000);
  static const textblack2 = Color(0x46000000);
  static const textblack = Color(0xFF4A4A4A);


  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    /// if [500] is the default color, there are at LEAST five
    /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
    /// divisor of 5 would mean [50] is a lightness of 1.0 or
    /// a color of #ffffff. A value of six would be near white
    /// but not quite.
    final lowDivisor = 6;

    /// if [500] is the default color, there are at LEAST four
    /// steps above [500]. A divisor of 4 would mean [900] is
    /// a lightness of 0.0 or color of #000000
    final highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}