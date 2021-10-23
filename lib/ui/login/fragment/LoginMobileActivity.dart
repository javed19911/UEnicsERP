import 'dart:async';

import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/utils/customWidget/customButton.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:UEnicsERP/utils/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import '../../../main.dart';
import '../../../multiLanguage/lanuages/language.dart';
import '../../base/BaseActivity.dart';
import '../iLogin.dart';
import '../vmLogin.dart';

import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';

/*import 'dart:ui' as ui;
import 'dart:html' as html;
import 'dart:js' as js;*/

class LoginMobileActivity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseActivity<LoginMobileActivity, vmLogin>
    implements iLogin {
  vmLogin? view_model;
  var formKey = GlobalKey<FormState>();
  var progress;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  @override
  void onCreate() async {
    super.onCreate();
    var view_model = getViewModel();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (view_model != null) {
        view_model.navigator = this;
        view_model.checkIfAlreadyLoggedIn();
      }
    });
  }

  @override
  Widget getWidget(BuildContext buildContext, vmLogin? vm) {
    this.view_model = vm;
    //vm.checkIfAlreadyLoggedIn();
    return Scaffold(
      backgroundColor: CustomColors.activityBg(),
      body: Container(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
          ),
          Logo(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(30),
              alignment: Alignment.center,
              child: Form(
                key: formKey,
                child: Card(
                  elevation: 10,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(18),
                        color: Colors.blue,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BoldText(
                              "Login",
                              fontSize: 27,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            SimpleText(
                              "Please sign in to continue.",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(28),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: Language.of(context).userLabel),
                              validator: checkEmptyValidation,
                              controller: _usernameController,
                              /*onChanged: (text) {
                                                    if (button_enabled != text.length >= 10) {
                                                      setState(() {
                                                        button_enabled = text.length >= 10;
                                                      });
                                                    }
                                                  },*/
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText:
                                      Language.of(context).passwordLabel),
                              validator: checkEmptyValidation,
                              controller: _passwordController,
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: RoundButton(
                                text: Language.of(context).loginLabel,
                                onPressed: () {
                                  if (vm?.mIsLoading != true) {
                                    if (formKey.currentState!.validate()) {
                                      vm?.validateUser(
                                          buildContext,
                                          _usernameController.text,
                                          _passwordController.text);
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: SimpleText(
              "UEnics©2021",
              fontSize: 10,
            ),
          )
        ],
      )),
    );
  }

  String? checkEmptyValidation(value) {
    if (value.isEmpty) {
      return Language.of(context).requiredWarningText;
    }
    return null;
  }

  @override
  void openDashboardActivity() {
    replaceNamedActivity("/dashboard");
  }
}
