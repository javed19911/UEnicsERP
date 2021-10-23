import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/base/BaseViewModel.dart';

import 'iAccount.dart';

class vmAccount extends BaseViewModel<iAccount> {
  late Menu menu;
  void addSubMenu(Menu menu) {
    this.menu = menu;
    notifyListeners();
  }
}
