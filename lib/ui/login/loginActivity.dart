import 'dart:async';

import 'package:UEnicsERP/ui/login/fragment/LoginMobileActivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../multiLanguage/lanuages/language.dart';
import '../../ui/base/BaseActivity.dart';
import '../../ui/login/vmLogin.dart';

import '../../main.dart';
import 'fragment/LoginWebActivity.dart';
import 'iLogin.dart';

class LoginActivity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseActivity<LoginActivity, vmLogin> {
  @override
  Widget getWidget(BuildContext buildContext, vmLogin? vm) {
    return Scaffold(
        body: ScreenTypeLayout(
      mobile: LoginMobileActivity(),
      tablet: LoginWebActivity(),
    ));
  }
}
