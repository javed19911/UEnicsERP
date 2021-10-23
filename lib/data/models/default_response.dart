class DefaultResponse {
  bool _success = false;
  Error? _error;

  bool get success => _success;
  Error? get error => _error;

  DefaultResponse();

  DefaultResponse.fromJson(dynamic json) {
    _success = json["success"] ?? false;
    if (json["error"] != null) {
      _error = Error.fromJson(json["error"]);
    } else {
      _error = Error();
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["error"] = _error?.toJson();
    return map;
  }
}

class Error {
  int? _code;
  String? _errorMessage;
  String? _type;

  Error();

  int? get code => _code;
  String? get errorMessage => _errorMessage;
  String? get type => _type;

  Error.fromJson(dynamic json) {
    _code = json["code"];
    _errorMessage = json["message"];
    _type = json["type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["type"] = _type;
    map["message"] = _errorMessage;
    return map;
  }
}
