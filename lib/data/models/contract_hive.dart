import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:hive/hive.dart';

part 'contract_hive.g.dart';

@HiveType(typeId: 1)
class ContractHive {
  @HiveField(0)
  String description;
  @HiveField(1)
  BillingPeriod billingPeriod;
  @HiveField(2)
  CategoryHive category;
  @HiveField(3)
  bool income;
  @HiveField(4)
  int amount;

  ContractHive({
    required this.description,
    required this.billingPeriod,
    required this.category,
    this.income = false,
    required this.amount,
  });
}
