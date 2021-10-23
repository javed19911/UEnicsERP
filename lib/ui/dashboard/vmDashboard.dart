import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/dashboard/iDashboard.dart';

import '../base/BaseViewModel.dart';

class vmDashboard extends BaseViewModel<iDashboard> {
  var menuJson = [
    {
      "code": "ACC",
      "name": "Accounts",
      "image": "lib/res/drawable/acc.jpeg",
      "action": "account",
      "sub_menus": [
        {
          "code": "DR",
          "name": "Doctor",
          "image": "lib/res/drawable/acc.jpeg",
        },
        {
          "code": "CHEM",
          "name": "Chemist",
          "image": "lib/res/drawable/inventory.png",
        },
        {
          "code": "STK",
          "name": "Stockiest",
          "image": "lib/res/drawable/trans.png",
        },
        {
          "code": "SSTK",
          "name": "Super Stockiest",
          "image": "lib/res/drawable/utilities.jpeg",
        },
        {
          "code": "DIST",
          "name": "Distributor",
          "image": "lib/res/drawable/trans.png",
        },
        {
          "code": "FRN",
          "name": "Franchise",
          "image": "lib/res/drawable/trans.png",
        },
        {
          "code": "BNK",
          "name": "Bank",
          "image": "lib/res/drawable/utilities.jpeg",
        },
        {
          "code": "OTH",
          "name": "Other",
          "image": "lib/res/drawable/utilities.jpeg",
        }
      ]
    },
    {
      "code": "INV",
      "name": "Item Master",
      "image": "lib/res/drawable/inventory.png",
    },
    {
      "code": "TRANS",
      "name": "Transactions",
      "image": "lib/res/drawable/trans.png",
    },
    {
      "code": "UTL",
      "name": "Utility",
      "image": "lib/res/drawable/utilities.jpeg",
      "action": "country",
    }
  ];

  List<Menu> menus = [];

  String? userName = "";

  void getUser() async {
    userName = await dataManager.getCurrentUserName();
  }

  void getMenus() {
    menus = [];
    menuJson.forEach((v) {
      menus.add(Menu.fromJson(v));
    });
    notifyListeners();
  }
  //List<String> menus = ["Accounts", "Item Master", "Transactions", "Utility"];
}
