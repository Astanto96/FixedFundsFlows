import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/domain/category.dart';

class Contract {
  int id;
  String description;
  BillingPeriod billingPeriod;
  Category category;
  bool income;
  int amount;

  Contract({
    required this.id,
    required this.description,
    required this.billingPeriod,
    required this.category,
    this.income = false,
    required this.amount,
  });
}
