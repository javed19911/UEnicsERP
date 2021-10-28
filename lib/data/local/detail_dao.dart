import 'package:hive/hive.dart';

import 'base_dao.dart';

part 'detail_dao.g.dart';

@HiveType(typeId: 1)
class DetailDao extends BaseDao {
  DetailDao() : super("Details");

  @HiveField(0)
  int id = 0;

  @HiveField(1)
  String? phone;

  @HiveField(2)
  String? mobile;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? aadhaar_no;

  @HiveField(5)
  String? pan_no;

  @HiveField(6)
  String? gst_no;
}
