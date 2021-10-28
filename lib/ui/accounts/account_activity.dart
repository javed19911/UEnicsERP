import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:flutter/material.dart';

import 'fragment/AccountMobileActivity.dart';
import 'fragment/AccountWebActivity.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AccountActivity extends StatefulWidget {
  final Menu menu;

  const AccountActivity({required this.menu});

  @override
  _AccountActivityState createState() => _AccountActivityState();
}

class _AccountActivityState extends State<AccountActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenTypeLayout(
      mobile: AccountMobileActivity(menu: widget.menu),
      tablet: AccountWebActivity(menu: widget.menu),
    ));
  }
}
