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
import '../../ui/login/login_vm.dart';

import '../../main.dart';
import 'fragment/LoginWebActivity.dart';
import 'login_view.dart';

class LoginActivity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseActivity<LoginActivity, LoginVM> {
  @override
  Widget getWidget(BuildContext buildContext, LoginVM? vm) {
    return Scaffold(
        body: ScreenTypeLayout(
      mobile: LoginMobileActivity(),
      tablet: LoginWebActivity(),
    ));
  }
}
