import 'package:hive/hive.dart';

abstract class BaseDao extends HiveObject {
  Box? _table;
  String _table_name;

  String get table_name => _table_name;

  BaseDao(this._table_name);

  Future<Box> getTable() async {
    if (_table == null || (_table == null && !_table!.isOpen)) {
      _table = await Hive.openBox(_table_name);
    }
    return _table!;
  }
}
