import 'dart:async';

import 'package:UEnicsERP/res/color.dart';
import 'package:UEnicsERP/ui/master_page/master_activity.dart';
import 'package:UEnicsERP/ui/master_page/master_vm.dart';
import 'package:UEnicsERP/utils/customWidget/customButton.dart';
import 'package:UEnicsERP/utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../../../multiLanguage/lanuages/language.dart';
import '../../base/BaseActivity.dart';
import '../login_view.dart';
import '../login_vm.dart';

class LoginWebActivity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseActivity<LoginWebActivity, LoginVM>
    implements LoginView {
  LoginVM? view_model;
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
  Widget getWidget(BuildContext buildContext, LoginVM? vm) {
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
                        // Container(
                        //   // color: CustomColors.logoBgColor,
                        //   padding: EdgeInsets.all(5),
                        //   child: Image(
                        //     width: 100,
                        //     height: 100,
                        //     image: AssetImage("lib/res/drawable/logo.png"),
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
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
                            style: TextStyle(color: Colors.black),
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
                            style: TextStyle(color: Colors.black),
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
    // replaceNamedActivity("/country");
    replaceNamedActivity("/master_setup");
    // replaceActivity(
    //     ChangeNotifierProvider(
    //       create: (context) => MasterVM(),
    //       child: MasterActivity(),
    //     ),
    //     rootNavigator: true);
  }
}
