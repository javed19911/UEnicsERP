import 'package:UEnicsERP/data/models/master_res.dart';

abstract class IMaster {
  Future<MasterRes> getMenus(String token);
}
