import 'default_response.dart';
import 'mUser.dart';

class LoginReponse extends DefaultResponse {
  mUser? _user;

  mUser? get user => _user;

  LoginReponse.fromJson(dynamic json) : super.fromJson(json) {
    _user = mUser.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    var map = super.toJson();
    map["data"] = _user?.toJson();

    return map;
  }
}
