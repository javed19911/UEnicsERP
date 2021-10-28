import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/data/repository/dashboard/dashboard_repository.dart';
import 'package:UEnicsERP/ui/dashboard/dashboard_view.dart';
import 'package:flutter/material.dart';

import '../base/BaseViewModel.dart';

class DashboardVM extends BaseViewModel<DashboardView, DashboardRepository> {
  List<Menu> menus = [];

  String? userName = "";

  void getUser() async {
    userName = await dataManager.getCurrentUserName();
  }

  void getMenus(BuildContext context) async {
    mIsLoading = true;
    notifyListeners();

    getRepository()?.getMenus("").then((response) {
      // print("response : ${response.toJson()}");
      menus = response.menus;
    }).catchError((e) {
      print("Got error: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString().replaceAll("Exception: ", ""),
        ),
        duration: Duration(seconds: 3),
      ));
    }).whenComplete(() {
      mIsLoading = false;
      notifyListeners();
    });
  }
}
