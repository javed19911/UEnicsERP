import 'dart:convert';

import 'package:UEnicsERP/data/models/default_response.dart';
import 'package:UEnicsERP/data/models/login_reponse.dart';
import 'package:UEnicsERP/data/repository/auth/i_auth.dart';
import 'package:UEnicsERP/data/remote/webservice.dart';
import 'package:http/http.dart' as http;

class AuthServices extends Webservice implements iAuth {
  @override
  Future<LoginReponse> login(String email, String password) async {
    Map data = {"user_id": "$email", "password": "$password"};
    var body = await postRequest("auth/login", data);
    return LoginReponse.fromJson(jsonDecode(body));
  }

  @override
  Future<DefaultResponse> logOut(String token) {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
