import 'dart:convert';

import 'package:UEnicsERP/data/models/dashboard_reponse.dart';
import 'package:UEnicsERP/data/models/master_res.dart';
import 'package:UEnicsERP/data/repository/dashboard/i_dashboard.dart';
import 'package:UEnicsERP/data/repository/master/i_master.dart';
import 'package:UEnicsERP/data/repository/master/master_repo.dart';

import 'webservice.dart';

class MasterServices extends Webservice implements IMaster {
  @override
  Future<MasterRes> getMenus(String token) async {
    Map data = {"token": "$token"};
    var body = {
      "data": [
        {
          "code": "DASH",
          "name": "Dashboard",
          "image": "lib/res/icons/menu_dashbord.svg",
          "action": "/dashboard"
        },
        {
          "code": "LGR",
          "name": "Ledger",
          "image": "lib/res/icons/menu_tran.svg",
          "action": "/ledger",
          "sub_menus": [
            {
              "code": "DR",
              "name": "Doctor",
              "image": "lib/res/drawable/acc.jpeg",
              "sub_menus": [
                {
                  "code": "VIEW",
                  "name": "View",
                  "image": "lib/res/drawable/inventory.png",
                  "action": "/",
                },
                {
                  "code": "WSMPL",
                  "name": "Web Sample",
                  "image": "lib/res/drawable/trans.png",
                  "action": "/web_sample",
                },
                {
                  "code": "EDIT",
                  "name": "Edit",
                  "image": "lib/res/drawable/trans.png",
                  "action": "/country",
                },
                {
                  "code": "DELETE",
                  "name": "Delete",
                  "image": "lib/res/drawable/utilities.jpeg",
                },
              ]
            },
            {
              "code": "CHEM",
              "name": "Chemist",
              "image": "lib/res/drawable/inventory.png",
              "action": "/country",
            },
            {
              "code": "STK",
              "name": "Stockiest",
              "image": "lib/res/drawable/trans.png",
              "action": "/",
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
          "name": "Inventory",
          "image": "lib/res/icons/menu_tran.svg",
          "action": "/inventory",
          "sub_menus": [
            {
              "code": "ITM",
              "name": "Item Master",
              "image": "lib/res/drawable/acc.jpeg",
              "sub_menus": [
                {
                  "code": "VIEW",
                  "name": "View",
                  "image": "lib/res/drawable/inventory.png",
                  "action": "/",
                },
                {
                  "code": "EDIT",
                  "name": "Edit",
                  "image": "lib/res/drawable/trans.png",
                  "action": "/country",
                },
                {
                  "code": "DELETE",
                  "name": "Delete",
                  "image": "lib/res/drawable/utilities.jpeg",
                },
              ]
            }
          ]
        },
        {
          "code": "TRANS",
          "name": "Transaction",
          "image": "lib/res/icons/menu_tran.svg",
          "action": "/accounts"
        },
        {
          "code": "TSK",
          "name": "Task",
          "image": "lib/res/icons/menu_task.svg",
          "action": "/task"
        },
        {
          "code": "DOC",
          "name": "Documents",
          "image": "lib/res/icons/menu_doc.svg",
          "action": "/document"
        },
        {
          "code": "STR",
          "name": "Store",
          "image": "lib/res/icons/menu_store.svg",
          "action": "/store"
        },
        {
          "code": "NOTIFY",
          "name": "Notification",
          "image": "lib/res/icons/menu_notification.svg",
          "action": "/notification"
        },
        {
          "code": "PRF",
          "name": "Profile",
          "image": "lib/res/icons/menu_profile.svg",
          "action": "/profile"
        },
        {
          "code": "SET",
          "name": "Settings",
          "image": "lib/res/icons/menu_setting.svg",
          "action": "/settings"
        }
      ]
    };
    //var body = await postRequest("menus", data);
    // return DashboardResponse.fromJson(jsonDecode(body));
    return MasterRes.fromJson(body);
  }
}
