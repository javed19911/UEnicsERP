import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/accounts/account_activity.dart';
import 'package:UEnicsERP/ui/accounts/account_vm.dart';
import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/country/country_activity.dart';
import 'package:UEnicsERP/ui/country/country_vm.dart';
import 'package:UEnicsERP/ui/dashboard/dashboard_activity.dart';
import 'package:UEnicsERP/ui/dashboard/dashboard_vm.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../master_activity.dart';
import '../master_route_generator.dart';
import '../master_vm.dart';
import 'header.dart';
import 'side_menu.dart';

class MasterMobileActivity extends StatefulWidget {
  const MasterMobileActivity({Key? key}) : super(key: key);

  @override
  _MasterMobileActivityState createState() => _MasterMobileActivityState();
}

class _MasterMobileActivityState
    extends BaseActivity<MasterMobileActivity, MasterVM> {
  @override
  Widget getWidget(BuildContext context, MasterVM? viewModel) {
    return Scaffold(
      key: viewModel?.scaffoldKey,
      drawer: SideMenu(
        menus: viewModel!.menus,
        selectedMenu: viewModel.selectedMenu,
        listener: (menu) {
          Navigator.of(context).pop();
          if (menu.code != viewModel.selectedMenu?.code) {
            viewModel.selectedMenu = menu;
            startNamedActivity(menu.action,
                navigatorKey: viewModel.masterNavigatorKey.currentState,
                args: menu);
          }
        },
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            Expanded(
                child: Navigator(
              key: viewModel.masterNavigatorKey,
              initialRoute: viewModel.initialRoute,
              onGenerateRoute: MasterRouteGenerator.generateRoute,
            )),
          ],
        ),
      ),
    );
  }
}
