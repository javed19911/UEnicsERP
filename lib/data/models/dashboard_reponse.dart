import 'default_response.dart';
import 'mMenu.dart';
import 'mUser.dart';

class DashboardResponse extends DefaultResponse {
  List<Menu> _menus = [];

  List<Menu> get menus => _menus;

  DashboardResponse.fromJson(dynamic json) : super.fromJson(json) {
    _menus = [];
    if (json["data"] != null) {
      json["data"].forEach((v) {
        _menus.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();

    if (_menus != null) {
      map["data"] = _menus.map((e) => e.toJson()).toList();
    }

    return map;
  }
}
