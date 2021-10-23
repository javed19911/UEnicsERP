import 'package:UEnicsERP/res/color.dart';
import 'package:flutter/material.dart';

import 'logo.dart';

class MyAppBar extends AppBar {
  MyAppBar({Key? key})
      : super(
          key: key,
          title: Logo(),
          centerTitle: false,
          backgroundColor: CustomColors.grayLightest(),
        );
}
