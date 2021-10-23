import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/Accounts/AccountActivity.dart';
import 'package:UEnicsERP/ui/Accounts/vmAccount.dart';
import 'package:UEnicsERP/ui/country/CountryActivity.dart';
import 'package:UEnicsERP/ui/country/vmCountry.dart';
import 'package:UEnicsERP/ui/dashboard/DashboardActivity.dart';
import 'package:UEnicsERP/ui/dashboard/vmDashboard.dart';
import 'package:UEnicsERP/ui/splashScreen/splashActivity.dart';
import 'package:flutter/material.dart';
import './ui/login/loginActivity.dart';
import './ui/login/vmLogin.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        //   return MaterialPageRoute(builder: (_) => SplashActivity());
        // case '/login':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => vmLogin(),
                  child: LoginActivity(),
                ));

      case '/dashboard':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => vmDashboard(),
                  child: DashboardActivity(),
                ));
      case '/accounts':
        if (args is Menu) {
          return MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                    create: (context) => vmAccount(),
                    child: AccountActivity(
                      menu: args,
                    ),
                  ));
        }
        return _errorRoute();
      case '/country':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => vmCountry(),
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
