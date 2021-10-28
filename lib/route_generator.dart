import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/Accounts/account_activity.dart';
import 'package:UEnicsERP/ui/country/country_activity.dart';
import 'package:UEnicsERP/ui/country/country_vm.dart';
import 'package:UEnicsERP/ui/dashboard/dashboard_activity.dart';
import 'package:UEnicsERP/ui/dashboard/dashboard_vm.dart';
import 'package:UEnicsERP/ui/master_page/master_activity.dart';
import 'package:UEnicsERP/ui/master_page/master_vm.dart';
import 'package:UEnicsERP/ui/splashScreen/splash_activity.dart';
import 'package:UEnicsERP/ui/splashScreen/splash_vm.dart';
import 'package:flutter/material.dart';
import './ui/login/login_activity.dart';
import './ui/login/login_vm.dart';
import 'package:provider/provider.dart';

import 'ui/accounts/account_vm.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    /*  else if (settings.name!.startsWith(routePrefixDeviceSetup)) {
    final subRoute =
    settings.name!.substring(routePrefixDeviceSetup.length);
    page = SetupFlow(
    setupPageRoute: subRoute,
    );
    }*/
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => SplashVM(),
                  child: SplashActivity(),
                ));
      case '/login':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => LoginVM(),
                  child: LoginActivity(),
                ));

      case '/master_setup':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => MasterVM(),
                  child: MasterSetupActivity(),
                ));
      case '/master':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => MasterVM(),
                  child: MasterActivity(),
                ));
      case '/dashboard':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => DashboardVM(),
                  child: DashboardActivity(),
                ));
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
        return _errorRoute();
      case '/country':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => CountryVM(),
                  child: CountryActivity(),
                ));

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

enum Activity { LOGIN, MOVIE }
