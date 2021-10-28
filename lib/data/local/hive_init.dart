import 'package:UEnicsERP/data/local/user_dao.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'detail_dao.dart';

Future<void> initHive() async {
  try {
    Hive
      ..initFlutter()
      ..registerAdapter(UserDaoAdapter())
      ..registerAdapter(DetailDaoAdapter());
    // var dir;
    // if (kIsWeb) {
    //
    //   dir = getExternalCacheDirectories();
    // } else {
    //   dir = await getApplicationDocumentsDirectory();
    // }
  } catch (e) {
    print("error ${e}");
  }
  // Hive
  //   ..init(dir.path)
  //   ..registerAdapter(UserDaoAdapter())
  //   ..registerAdapter(DetailDaoAdapter());
}
