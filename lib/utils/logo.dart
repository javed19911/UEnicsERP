import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final Color? color;
  final double textSize;
  const Logo({Key? key, this.color, this.textSize = 22}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText(
            "UEnics ERP",
            fontSize: textSize,
            alignment: TextAlign.center,
            color: color ?? CustomColors.darkGreen(),
          ),
          Container(
            color: color ?? CustomColors.darkGreen(),
            margin: EdgeInsets.only(top: 5),
            width: 50,
            height: 3,
          )
        ],
      ),
    );
  }
}
