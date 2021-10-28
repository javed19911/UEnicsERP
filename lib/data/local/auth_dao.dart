import 'package:UEnicsERP/data/models/default_response.dart';
import 'package:UEnicsERP/data/models/login_reponse.dart';
import 'package:UEnicsERP/data/repository/auth/i_auth.dart';

class AuthDao implements iAuth {
  @override
  Future<LoginReponse> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<DefaultResponse> logOut(String token) {
    // TODO: implement logOut
    throw UnimplementedError();
  }
}
