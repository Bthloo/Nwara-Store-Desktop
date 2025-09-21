// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profit_sharing_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfitSharingModelAdapter extends TypeAdapter<ProfitSharingModel> {
  @override
  final int typeId = 2;

  @override
  ProfitSharingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfitSharingModel(
      name: fields[0] as String,
      amount: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ProfitSharingModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfitSharingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
