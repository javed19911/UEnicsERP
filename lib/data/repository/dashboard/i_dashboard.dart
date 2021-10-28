import 'package:UEnicsERP/data/models/dashboard_reponse.dart';

abstract class IDashboard {
  Future<DashboardResponse> getMenus(String token);
}
