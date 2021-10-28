import 'package:UEnicsERP/data/models/dashboard_reponse.dart';
import 'package:UEnicsERP/data/remote/dashboard_service.dart';

import 'i_dashboard.dart';

class DashboardRepository implements IDashboard {
  // var dao = UserDao();
  var service = DashBoardServices();
  @override
  Future<DashboardResponse> getMenus(String token) async {
    return await service.getMenus(token);
  }
}
