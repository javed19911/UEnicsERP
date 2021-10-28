import 'package:UEnicsERP/data/models/mMenu.dart';
import 'package:UEnicsERP/ui/base/BaseViewModel.dart';

import 'account_view.dart';

class AccountVM extends BaseViewModel<AccountView, Object> {
  late Menu menu;
  void addSubMenu(Menu menu) {
    this.menu = menu;
    notifyListeners();
  }
}
