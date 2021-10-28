import 'package:hive/hive.dart';

import 'base_dao.dart';
import 'detail_dao.dart';

part 'user_dao.g.dart';

@HiveType(typeId: 0)
class UserDao extends BaseDao {
  UserDao(
      {this.id = 0,
      this.code,
      this.first_name,
      this.last_name,
      this.details,
      this.manager,
      this.team})
      : super("User");

  @HiveField(0)
  int id = 0;

  @HiveField(1)
  String? code;

  @HiveField(2)
  String? first_name;

  @HiveField(3)
  String? last_name;

  @HiveField(4)
  UserDao? manager;

  @HiveField(5)
  List<UserDao>? team;

  @HiveField(6)
  DetailDao? details;
}
