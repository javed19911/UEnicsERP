import 'dart:convert';

import 'package:UEnicsERP/data/models/dashboard_reponse.dart';
import 'package:UEnicsERP/data/repository/dashboard/i_dashboard.dart';

import 'webservice.dart';

class DashBoardServices extends Webservice implements IDashboard {
  @override
  Future<DashboardResponse> getMenus(String token) async {
    Map data = {"token": "$token"};
    var body = {
      "data": [
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
      ]
    };
    //var body = await postRequest("menus", data);
    // return DashboardResponse.fromJson(jsonDecode(body));
    return DashboardResponse.fromJson(body);
  }
}
