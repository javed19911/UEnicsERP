import 'package:UEnicsERP/data/models/mItemGroup.dart';

import 'mUint.dart';

class Item {
  int? id;
  String? code;
  String? name;
  String? description;
  ItemGroup? itemGroup;
  Unit? unit;
  Unit? alternateUnit;
}
