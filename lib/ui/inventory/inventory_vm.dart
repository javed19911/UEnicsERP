import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/base/BaseViewModel.dart';
import 'package:flutter/material.dart';

import 'inventory_view.dart';

class InventoryVM extends BaseViewModel<InventoryView, Object> {
  final navigatorKey = GlobalKey<NavigatorState>();
  String initialRoute = "/";
  Menu? menu;
  Menu? subMenu;
  Menu? subSubMenu;

  Menu getDisplayMenu() {
    if (subMenu == null) {
      if (menu!.subMenus != null) {
        subMenu = menu?.subMenus!.first;
        if (subSubMenu == null) {
          if (subMenu!.subMenus != null) {
            subSubMenu = subMenu!.subMenus!.first;
          } else {
            subSubMenu = null;
          }
        } else {
          subMenu = null;
        }
      }
    } else if (subSubMenu == null) {
      if (subMenu!.subMenus != null) {
        subSubMenu = subMenu!.subMenus!.first;
      } else {
        subSubMenu = null;
      }
    }

    var displayMenu = menu;
    if (subSubMenu != null) {
      displayMenu = subSubMenu!;
    } else if (subMenu != null) {
      displayMenu = subMenu!;
    }

    return displayMenu!;
  }
}
