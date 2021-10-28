import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/base_child_page/base_child_activity.dart';
import 'package:UEnicsERP/ui/inventory/inventory_route_generator.dart';
import 'package:UEnicsERP/ui/inventory/inventory_vm.dart';
import 'package:UEnicsERP/ui/master_page/components/top_menu.dart';
import 'package:flutter/material.dart';

import 'inventory_view.dart';

class InventoryActivity extends BaseChildActivity {
  final Menu menu;
  Menu? subMenu;
  Menu? subSubMenu;

  InventoryActivity(
      {Key? key, required this.menu, this.subMenu, this.subSubMenu})
      : super(
            key: key,
            menu: menu,
            subMenu: subMenu,
            subSubMenu: subSubMenu,
            onGenerateRoute: InventoryRouteGenerator.generateRoute);

  // @override
  // _InventoryActivityState createState() => _InventoryActivityState();
}

class _InventoryActivityState
    extends BaseActivity<InventoryActivity, InventoryVM>
    implements InventoryView {
  InventoryVM? vm;

  @override
  void onCreate() {
    vm = getViewModel();
    vm?.menu = widget.menu;
    vm?.subMenu = widget.subMenu;
    vm?.subSubMenu = widget.subSubMenu;
    var initialDisplayMenu = vm?.getDisplayMenu();
    vm?.initialRoute = initialDisplayMenu!.action;
    super.onCreate();
  }

  @override
  void openMenuForm(Menu menu) {
    //print(menu.toJson());
    // if (menu.action != null && menu.action.isNotEmpty) {
    startNamedActivity(menu.action,
        navigatorKey: vm?.navigatorKey.currentState);
    // }
  }

  @override
  Widget getWidget(BuildContext context, InventoryVM? viewModel) {
    // print(widget.menu.toJson());
    vm = viewModel;
    return Container(
      child: Column(
        children: [
          TopMenu(
            vm!.menu!,
            elevation: 8,
            iconSize: 30,
            color: Colors.white12,
            selectedMenu: vm!.subMenu,
            listener: (menu) {
              if (menu.code != vm?.subMenu?.code) {
                setState(() {
                  vm!.subMenu = menu;
                  vm!.subSubMenu = null;
                  var displayMenu = vm!.getDisplayMenu();
                  openMenuForm(displayMenu);
                });
              }
            },
          ),
          if (vm!.subMenu != null)
            TopMenu(
              vm!.subMenu!,
              elevation: 5,
              iconSize: 25,
              selectedIcon: Icons.remove,
              color: Colors.white54,
              selectedMenu: vm!.subSubMenu,
              listener: (subMenu) {
                if (subMenu.code != vm?.subSubMenu?.code) {
                  setState(() {
                    vm!.subSubMenu = subMenu;
                    openMenuForm(subMenu);
                  });
                }
              },
            ),
          Expanded(
            child: WillPopScope(
                onWillPop: _isExitDesired,
                child: Navigator(
                  key: vm!.navigatorKey,
                  initialRoute: vm!.initialRoute,
                  onGenerateRoute: InventoryRouteGenerator.generateRoute,
                )),
          )
        ],
      ),
    );
  }

  Future<bool> _isExitDesired() async {
    if (vm!.navigatorKey.currentState!.canPop()) {
      vm!.navigatorKey.currentState!.pop(false);
      return false;
    } else {
      return true;
    }
  }
}
