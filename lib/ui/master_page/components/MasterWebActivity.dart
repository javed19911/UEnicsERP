import 'package:UEnicsERP/ui/base/BaseActivity.dart';
import 'package:UEnicsERP/ui/master_page/components/header.dart';
import 'package:flutter/material.dart';

import '../master_route_generator.dart';
import '../master_vm.dart';
import 'side_menu.dart';

class MasterWebActivity extends StatefulWidget {
  const MasterWebActivity({Key? key}) : super(key: key);
  @override
  _MasterWebActivityState createState() => _MasterWebActivityState();
}

class _MasterWebActivityState
    extends BaseActivity<MasterWebActivity, MasterVM> {
  @override
  Widget getWidget(BuildContext context, MasterVM? viewModel) {
    return Scaffold(
      key: viewModel?.scaffoldKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(
                menus: viewModel!.menus,
                selectedMenu: viewModel.selectedMenu,
                elevation: 15,
                listener: (menu) {
                  if (menu.code != viewModel.selectedMenu?.code) {
                    viewModel.selectedMenu = menu;
                    startNamedActivity(menu.action,
                        navigatorKey: viewModel.masterNavigatorKey.currentState,
                        args: menu);
                  }
                },
              ),
            ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  Expanded(
                    child: ClipRect(
                      child: Navigator(
                        key: viewModel.masterNavigatorKey,
                        initialRoute: viewModel.initialRoute,
                        onGenerateRoute: MasterRouteGenerator.generateRoute,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
