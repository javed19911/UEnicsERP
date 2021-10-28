import 'package:flutter/material.dart';

extension CustomColors on Colors {
  static const primaryColor = Color(0xFF2697FF);
  // static const secondaryColor = Color(0xFF2A2D3E);
  static const secondaryColor = Color(0xFFF6F4F5);
  // static const bgColor = Color(0xFFcbc3d0);
  static const bgColor = Color(0xFFF3F4F7);
  static const logoBgColor = Color(0xFFD28C87);

  static Color graySofi({double colorOpacity = 1.0}) =>
      Color(0xFF5E5E5E).withOpacity(colorOpacity);

  static Color darkGreen({double colorOpacity = 1.0}) =>
      Color(0xFF07654E).withOpacity(colorOpacity);

  static Color darkOrange({double colorOpacity = 1.0}) =>
      Color(0xFFF35800).withOpacity(colorOpacity);

  static Color grayLightest({double colorOpacity = 1.0}) =>
      Color(0xFFC7D0C3).withOpacity(colorOpacity);

  static Color darkGray({double colorOpacity = 1.0}) =>
      Color(0xFF353834).withOpacity(colorOpacity);

  static Color grayLight({double colorOpacity = 1.0}) =>
      Color(0xFF838A81).withOpacity(colorOpacity);

  static Color brown({double colorOpacity = 1.0}) =>
      Color(0xFFA07658).withOpacity(colorOpacity);

  static Color title({double colorOpacity = 1.0}) =>
      Color(0xFF009900).withOpacity(colorOpacity);

  static Color activityBg({double colorOpacity = 1.0}) =>
      Color(0xFFE6FAFF).withOpacity(colorOpacity);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
