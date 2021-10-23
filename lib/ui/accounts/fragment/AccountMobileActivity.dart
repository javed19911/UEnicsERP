import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/Accounts/vmAccount.dart';
import 'package:UEnicsERP/utils/myAppBar.dart';
import 'package:flutter/material.dart';

import '../../base/BaseActivity.dart';

class AccountMobileActivity extends StatefulWidget {
  late Menu menu;

  AccountMobileActivity({required this.menu});

  @override
  _AccountMobileActivityState createState() => _AccountMobileActivityState();
}

class _AccountMobileActivityState
    extends BaseActivity<AccountMobileActivity, vmAccount> {
  @override
  void onCreate() {
    // TODO: implement onCreate
    var vm = getViewModel();
    vm?.addSubMenu(widget.menu);
    super.onCreate();
  }

  @override
  Widget getWidget(BuildContext context, vmAccount? view_model) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Text("Accounts"),
      ),
    );
  }
}
