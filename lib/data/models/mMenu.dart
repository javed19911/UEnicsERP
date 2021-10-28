class Menu {
  late String _code;
  late String _name;
  late String _image;
  late String _action;
  List<Menu>? _sub_menus;

  String get code => _code;

  set code(String value) {
    _code = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get action => _action;

  set action(String value) {
    _action = value;
  }

  List<Menu>? get subMenus => _sub_menus;

  set subMenus(List<Menu>? value) {
    _sub_menus = value;
  }

  Menu.fromJson(dynamic json) {
    _code = json["code"];
    _name = json["name"];
    _image = json["image"];
    _action = json["action"] ?? "";
    if (json["sub_menus"] != null) {
      _sub_menus = [];
      json["sub_menus"].forEach((v) {
        _sub_menus?.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["name"] = _name;
    map["image"] = _image;
    map["action"] = _action;
    if (_sub_menus != null) {
      map["sub_menus"] = _sub_menus?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
