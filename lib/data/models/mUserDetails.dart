class mUserDetails {
  late int _id;
  late String _email;
  late String? _phoneNumber;
  late String _mobileNumber;
  late String? _aadharNumber;
  late String _panNumber;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String? get phoneNumber => _phoneNumber;

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  String get mobileNumber => _mobileNumber;

  set mobileNumber(String value) {
    _mobileNumber = value;
  }

  String? get aadharNumber => _aadharNumber;

  set aadharNumber(String? value) {
    _aadharNumber = value;
  }

  String get panNumber => _panNumber;

  set panNumber(String value) {
    _panNumber = value;
  }

  mUserDetails.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    if (json['email'] != null && json['email'] != "null")
      _email = json['email'];
    else
      _email = "";

    if (json['phone'] != null && json['phone'] != "null")
      _phoneNumber = json['phone'];
    else
      _phoneNumber = "";

    if (json['mobile'] != null && json['mobile'] != "null")
      _mobileNumber = json['mobile'];
    else
      _mobileNumber = "";

    if (json['aadhaar_no'] != null && json['aadhaar_no'] != "null")
      _aadharNumber = json['aadhaar_no'];
    else
      _aadharNumber = "";

    if (json['pan_no'] != null && json['pan_no'] != "null")
      _panNumber = json['pan_no'];
    else
      _panNumber = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['email'] = this._email;
    data['phone'] = this._phoneNumber;
    data['mobile'] = this._mobileNumber;
    data['aadhaar_no'] = this._aadharNumber;
    data['pan_no'] = this._panNumber;
    return data;
  }
}
