// ignore: camel_case_types
import 'package:UEnicsERP/data/models/default_response.dart';
import 'package:UEnicsERP/data/models/login_reponse.dart';

abstract class iAuth {
  Future<LoginReponse> login(String email, String password);
  Future<DefaultResponse> logOut(String token);
}
