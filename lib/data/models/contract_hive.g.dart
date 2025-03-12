// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContractHiveAdapter extends TypeAdapter<ContractHive> {
  @override
  final int typeId = 1;

  @override
  ContractHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContractHive(
      description: fields[0] as String,
      billingPeriod: fields[1] as BillingPeriodHive,
      categoryId: fields[2] as int,
      income: fields[3] as bool,
      amount: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ContractHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.billingPeriod)
      ..writeByte(2)
      ..write(obj.categoryId)
      ..writeByte(3)
      ..write(obj.income)
      ..writeByte(4)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContractHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
