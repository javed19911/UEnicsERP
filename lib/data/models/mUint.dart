enum UnitType { SIMPLE, COMPOUND }

class Unit {
  int? id;
  String? symbol;
  String? name;
  UnitType type = UnitType.SIMPLE;
  int noOfDecimalPlaces = 0;
  Unit? firstUnit;
  Unit? secoundUnit;
  int conversion = 1;
}
