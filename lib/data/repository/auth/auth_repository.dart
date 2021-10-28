import 'package:UEnicsERP/data/local/auth_dao.dart';
import 'package:UEnicsERP/data/local/detail_dao.dart';
import 'package:UEnicsERP/data/local/user_dao.dart';
import 'package:UEnicsERP/data/models/default_response.dart';
import 'package:UEnicsERP/data/models/login_reponse.dart';
import 'package:UEnicsERP/data/remote/auth_services.dart';
import 'package:UEnicsERP/data/repository/auth/i_auth.dart';

class AuthRepository implements iAuth {
  var dao = UserDao();
  var service = AuthServices();
  @override
  Future<LoginReponse> login(String email, String password) async {
    var response = await service.login(email, password);
    dao.getTable().then((box) {
      box.put("loginUser", response.user?.toJson());
    });
    return response;
  }

  @override
  Future<DefaultResponse> logOut(String token) {
    return service.logOut(token);
  }
}
