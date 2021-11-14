import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/Accounts/account_activity.dart';
import 'package:UEnicsERP/ui/accounts/account_vm.dart';
import 'package:UEnicsERP/ui/country/country_activity.dart';
import 'package:UEnicsERP/ui/country/country_vm.dart';
import 'package:UEnicsERP/ui/inventory/item/item_master_activity.dart';
import 'package:UEnicsERP/ui/inventory/item/item_master_vm.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        // if (args is Menu) {
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => AccountVM(),
                  child: AccountActivity(
                    menu: Menu.fromJson(
                        {"code": "code", "name": "test", "image": ""}),
                  ),
                ));
      // }
      // return _errorRoute(settings);
      case '/country':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => CountryVM(),
                  child: CountryActivity(),
                ));
      case '/item':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => ItemMasterVM(),
                  child: ItemMasterActivity(),
                ));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Container(
                  alignment: Alignment.center,
                  child: SimpleText(
                      "404 Page not found for route ${settings.name}")),
            ));
  }
}

enum MasterActivity { LOGIN, MOVIE }
