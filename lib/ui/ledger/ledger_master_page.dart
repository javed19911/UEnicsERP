import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/base_child_page/base_child_activity.dart';
import 'package:flutter/material.dart';

import 'ledger_route_generator.dart';

class LedgerMasterPage extends BaseChildActivity {
  final Menu menu;
  Menu? subMenu;
  Menu? subSubMenu;

  LedgerMasterPage(
      {Key? key, required this.menu, this.subMenu, this.subSubMenu})
      : super(
            key: key,
            menu: menu,
            subMenu: subMenu,
            subSubMenu: subSubMenu,
            onGenerateRoute: LedgerRouteGenerator.generateRoute);
}
