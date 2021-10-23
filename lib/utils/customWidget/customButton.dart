import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:flutter/material.dart';

class RoundButton extends MaterialButton {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color textColor;

  RoundButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color = Colors.blue,
      this.textColor = Colors.white})
      : super(
          key: key,
          minWidth: 200,
          height: 45,
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          textColor: textColor,
          onPressed: onPressed,
          child: BoldText(
            text,
            color: textColor,
          ),
        );
}
