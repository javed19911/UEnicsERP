import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/Accounts/account_activity.dart';
import 'package:UEnicsERP/ui/accounts/account_vm.dart';
import 'package:UEnicsERP/ui/base_child_page/base_child_vm.dart';
import 'package:UEnicsERP/ui/country/country_activity.dart';
import 'package:UEnicsERP/ui/country/country_vm.dart';
import 'package:UEnicsERP/ui/dashboard/dashboard_activity.dart';
import 'package:UEnicsERP/ui/dashboard/dashboard_vm.dart';
import 'package:UEnicsERP/ui/inventory/inventory_activity.dart';
import 'package:UEnicsERP/ui/inventory/inventory_master_page.dart';
import 'package:UEnicsERP/ui/inventory/inventory_vm.dart';
import 'package:UEnicsERP/ui/ledger/ledger_master_page.dart';
import 'package:UEnicsERP/utils/customWidget/customText.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MasterRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
      case '/dashboard':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => DashboardVM(),
                  child: DashboardActivity(),
                ));
      case '/ledger':
        if (args is Menu) {
          return MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                    create: (context) => BaseChildVM(),
                    child: LedgerMasterPage(
                      menu: args,
                    ),
                  ));
        }
        return _errorRoute(settings);

      case '/inventory':
        if (args is Menu) {
          return MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                    create: (context) => BaseChildVM(),
                    child: InventoryMasterPage(
                      menu: args,
                    ),
                  ));
        }
        return _errorRoute(settings);

      case '/accounts':
        if (args is Menu) {
          return MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                    create: (context) => AccountVM(),
                    child: AccountActivity(
                      menu: args,
                    ),
                  ));
        }
        return _errorRoute(settings);
      case '/country':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => CountryVM(),
                  child: CountryActivity(),
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
