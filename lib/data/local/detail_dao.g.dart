// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_dao.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailDaoAdapter extends TypeAdapter<DetailDao> {
  @override
  final int typeId = 1;

  @override
  DetailDao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailDao()
      ..id = fields[0] as int
      ..phone = fields[1] as String?
      ..mobile = fields[2] as String?
      ..email = fields[3] as String?
      ..aadhaar_no = fields[4] as String?
      ..pan_no = fields[5] as String?
      ..gst_no = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, DetailDao obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.mobile)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.aadhaar_no)
      ..writeByte(5)
      ..write(obj.pan_no)
      ..writeByte(6)
      ..write(obj.gst_no);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailDaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
