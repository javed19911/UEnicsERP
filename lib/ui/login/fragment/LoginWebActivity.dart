import 'dart:async';

import 'package:UEnicsERP/utils/customWidget/customButton.dart';
import 'package:UEnicsERP/utils/logo.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../multiLanguage/lanuages/language.dart';
import '../../base/BaseActivity.dart';
import '../iLogin.dart';
import '../vmLogin.dart';

class LoginWebActivity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseActivity<LoginWebActivity, vmLogin>
    implements iLogin {
  vmLogin? view_model;
  var progress;
  var formKey = GlobalKey<FormState>();

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
    return Container(
        child: Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          child: Image.asset('lib/res/drawable/erp_bg.jpeg'),
          fit: BoxFit.cover,
        ),
        Center(
          child: Container(
            width: 600,
            height: 400,
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Logo(
                          color: Colors.white,
                          textSize: 20,
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Signin",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold)),
                              Container(
                                color: Colors.blue,
                                margin: EdgeInsets.only(top: 5),
                                width: 30,
                                height: 3,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                                labelText: Language.of(context).passwordLabel),
                            validator: checkEmptyValidation,
                            controller: _passwordController,
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RoundButton(
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
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
        Center(
          child:
              vm?.mIsLoading == true ? new CircularProgressIndicator() : null,
        )
      ],
    ));
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
