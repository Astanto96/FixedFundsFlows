// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_period_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillingPeriodAdapter extends TypeAdapter<BillingPeriod> {
  @override
  final int typeId = 2;

  @override
  BillingPeriod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BillingPeriod.monthly;
      case 1:
        return BillingPeriod.quarterly;
      case 2:
        return BillingPeriod.yearly;
      default:
        return BillingPeriod.monthly;
    }
  }

  @override
  void write(BinaryWriter writer, BillingPeriod obj) {
    switch (obj) {
      case BillingPeriod.monthly:
        writer.writeByte(0);
        break;
      case BillingPeriod.quarterly:
        writer.writeByte(1);
        break;
      case BillingPeriod.yearly:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillingPeriodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
