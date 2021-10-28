import 'package:UEnicsERP/data/repository/auth/auth_repository.dart';
import 'package:UEnicsERP/data/repository/dashboard/dashboard_repository.dart';
import 'package:UEnicsERP/data/repository/ledger/ledger_repo.dart';
import 'package:UEnicsERP/data/repository/master/master_repo.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  // locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
  locator.registerFactory<AuthRepository>(() => AuthRepository());
  locator.registerFactory<DashboardRepository>(() => DashboardRepository());
  locator.registerFactory<MasterRepo>(() => MasterRepo());
  locator.registerFactory<LedgerRepo>(() => LedgerRepo());
}
