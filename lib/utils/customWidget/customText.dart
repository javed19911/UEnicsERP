import 'package:UEnicsERP/res/color.dart';
import 'package:flutter/material.dart';

class SimpleText extends Text {
  final Color? color;
  final Color? bgColor;
  final double? fontSize;
  final TextAlign? alignment;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  SimpleText(String data,
      {this.color,
      this.bgColor,
      this.fontSize,
      this.alignment,
      this.fontWeight,
      this.fontStyle})
      : super(data,
            textAlign: alignment,
            style: TextStyle(
                fontSize: fontSize,
                fontStyle: fontStyle,
                fontWeight: fontWeight,
                color: color, //?? CustomColors.graySofi(),
                backgroundColor: bgColor));
}

class UnderLineText extends Text {
  final Color? color;
  final Color? bgColor;
  final double? fontSize;
  final TextAlign? alignment;
  UnderLineText(String data,
      {this.color, this.bgColor, this.fontSize, this.alignment})
      : super(data,
            textAlign: alignment,
            style: TextStyle(
              fontSize: fontSize,
              color: color, //?? CustomColors.graySofi(),
              backgroundColor: bgColor,
              decoration: TextDecoration.underline,
            ));
}

class BoldText extends Text {
  final Color? color;
  final Color? bgColor;
  final double? fontSize;
  final TextAlign? alignment;
  BoldText(String data,
      {this.color, this.bgColor, this.fontSize, this.alignment})
      : super(data,
            textAlign: alignment,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: color, //?? CustomColors.graySofi(),
                backgroundColor: bgColor));
}

class BoldItalicText extends Text {
  final Color? color;
  final Color? bgColor;
  final double? fontSize;
  final TextAlign? alignment;
  BoldItalicText(String data,
      {this.color, this.bgColor, this.fontSize, this.alignment})
      : super(data,
            textAlign: alignment,
            style: TextStyle(
                fontSize: fontSize,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: color, // ?? CustomColors.graySofi(),
                backgroundColor: bgColor));
}

class ItalicText extends Text {
  final Color? color;
  final Color? bgColor;
  final double? fontSize;
  final TextAlign? alignment;
  ItalicText(String data,
      {this.color, this.bgColor, this.fontSize, this.alignment})
      : super(data,
            textAlign: alignment,
            style: TextStyle(
                fontSize: fontSize,
                fontStyle: FontStyle.italic,
                color: color, //?? CustomColors.graySofi(),
                backgroundColor: bgColor));
}

class BoldUnderLineText extends Text {
  final Color? color;
  final Color? bgColor;
  final double? fontSize;
  final TextAlign? alignment;
  BoldUnderLineText(String data,
      {this.color, this.bgColor, this.fontSize, this.alignment})
      : super(data,
            textAlign: alignment,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color, //?? CustomColors.graySofi(),
              backgroundColor: bgColor,
              decoration: TextDecoration.underline,
            ));
}
