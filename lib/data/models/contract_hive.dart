import 'package:fixedfundsflows/data/mapper/billing_period_mapper.dart';
import 'package:fixedfundsflows/data/models/billing_period_hive.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:hive/hive.dart';

part 'contract_hive.g.dart';

@HiveType(typeId: 1)
class ContractHive extends HiveObject {
  @HiveField(0)
  String description;
  @HiveField(1)
  BillingPeriodHive billingPeriod;
  @HiveField(2)
  int categoryId;
  @HiveField(3)
  bool income;
  @HiveField(4)
  int amount;

  ContractHive({
    required this.description,
    required this.billingPeriod,
    required this.categoryId,
    this.income = false,
    required this.amount,
  });

  factory ContractHive.fromDomain(Contract contract) {
    return ContractHive(
      description: contract.description,
      billingPeriod: BillingPeriodMapper.toHive(contract.billingPeriod),
      categoryId: contract.category.id!,
      amount: contract.amount,
    );
  }

  Contract toDomain(CategoryHive category) {
    return Contract(
      id: key as int,
      description: description,
      billingPeriod: BillingPeriodMapper.toDomain(billingPeriod),
      category:
          Category(id: category.key as int, description: category.description),
      amount: amount,
    );
  }
}
