import 'package:hive/hive.dart';

part 'billing_period_hive.g.dart';

@HiveType(typeId: 2)
enum BillingPeriod {
  @HiveField(0)
  monthly,

  @HiveField(1)
  quarterly,

  @HiveField(2)
  yearly,
}
