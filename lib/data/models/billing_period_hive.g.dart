// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_period_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillingPeriodHiveAdapter extends TypeAdapter<BillingPeriodHive> {
  @override
  final int typeId = 2;

  @override
  BillingPeriodHive read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BillingPeriodHive.monthly;
      case 1:
        return BillingPeriodHive.quarterly;
      case 2:
        return BillingPeriodHive.yearly;
      default:
        return BillingPeriodHive.monthly;
    }
  }

  @override
  void write(BinaryWriter writer, BillingPeriodHive obj) {
    switch (obj) {
      case BillingPeriodHive.monthly:
        writer.writeByte(0);
        break;
      case BillingPeriodHive.quarterly:
        writer.writeByte(1);
        break;
      case BillingPeriodHive.yearly:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillingPeriodHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
