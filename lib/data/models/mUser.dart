import 'package:UEnicsERP/data/models/mUserDetails.dart';

class mUser {
  late int _id;
  late String _first_name;
  late String? _last_name;
  late mUserDetails? _user_details;
  late String _code;

  int get id => _id;

  String get firstName => _first_name;

  String? get lastName => _last_name;

  mUserDetails? get userDetails => _user_details;

  String get code => _code;

  set id(int value) {
    _id = value;
  }

  set firstName(String value) {
    _first_name = value;
  }

  set lastName(String? value) {
    _last_name = value;
  }

  set userDetails(mUserDetails? value) {
    _user_details = value;
  }

  set code(String value) {
    _code = value;
  }

  mUser.fromJson(Map<String, dynamic> json) {
    _id = json['id'];

    if (json['first_name'] != null && json['first_name'] != "null")
      _first_name = json['first_name'];
    else
      _first_name = "";

    if (json['last_name'] != null && json['last_name'] != "null")
      _last_name = json['last_name'];
    else
      _last_name = "";

    if (json['code'] != null && json['code'] != "null")
      _code = json['code'];
    else
      _code = "";

    if (json['details'] != null && json['details'] != "null")
      _user_details = mUserDetails.fromJson(json['details']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['first_name'] = this._first_name;
    data['last_name'] = this._last_name;
    data['code'] = this._code;
    data['details'] = this._user_details?.toJson();
    return data;
  }
}
