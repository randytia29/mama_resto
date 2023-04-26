import 'dart:ui';

import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#FF4081');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black = HexColor.fromHex('#000000');
  static Color grey = HexColor.fromHex('#9E9E9E');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }

    return Color(int.parse(hexColorString, radix: 16));
  }
}
