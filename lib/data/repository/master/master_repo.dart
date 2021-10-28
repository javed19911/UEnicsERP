import 'package:UEnicsERP/data/models/master_res.dart';
import 'package:UEnicsERP/data/remote/master_service.dart';
import 'package:UEnicsERP/data/repository/master/i_master.dart';

class MasterRepo implements IMaster {
  // var dao = UserDao();
  var service = MasterServices();

  @override
  Future<MasterRes> getMenus(String token) async {
    return await service.getMenus(token);
  }
}
