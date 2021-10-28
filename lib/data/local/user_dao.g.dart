// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDaoAdapter extends TypeAdapter<UserDao> {
  @override
  final int typeId = 0;

  @override
  UserDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDao(
      id: fields[0] as int,
      code: fields[1] as String?,
      first_name: fields[2] as String?,
      last_name: fields[3] as String?,
      details: fields[6] as DetailDao?,
      manager: fields[4] as UserDao?,
      team: (fields[5] as List?)?.cast<UserDao>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserDao obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.first_name)
      ..writeByte(3)
      ..write(obj.last_name)
      ..writeByte(4)
      ..write(obj.manager)
      ..writeByte(5)
      ..write(obj.team)
      ..writeByte(6)
      ..write(obj.details);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
