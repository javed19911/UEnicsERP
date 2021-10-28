import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/data/repository/master/master_repo.dart';
import 'package:UEnicsERP/ui/base/BaseViewModel.dart';
import 'package:UEnicsERP/ui/master_page/master_view.dart';
import 'package:flutter/material.dart';

class MasterVM extends BaseViewModel<MasterView, MasterRepo> {
  List<Menu> menus = [];
  Menu? selectedMenu;
  String initialRoute = "/";
  final masterNavigatorKey = GlobalKey<NavigatorState>();
  final dashboardNavigatorKey = GlobalKey<NavigatorState>();
  final accountNavigatorKey = GlobalKey<NavigatorState>();
  final inventoryNavigatorKey = GlobalKey<NavigatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  void getMenus(BuildContext context) async {
    mIsLoading = true;
    notifyListeners();

    getRepository()?.getMenus("").then((response) {
      // print("response : ${response.toJson()}");
      menus = response.menus;
      if (menus.length > 0) {
        selectedMenu = menus.first;
        initialRoute = selectedMenu!.action;
      }
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
