import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/domain/category.dart';

class Contract {
  int? id;
  String description;
  BillingPeriod billingPeriod;
  Category category;

  int amount;

  Contract({
    this.id,
    required this.description,
    required this.billingPeriod,
    required this.category,
    required this.amount,
  });

  Contract copyWith({
    int? id,
    String? description,
    BillingPeriod? billingPeriod,
    Category? category,
    int? amount,
  }) {
    return Contract(
      id: id ?? this.id,
      description: description ?? this.description,
      billingPeriod: billingPeriod ?? this.billingPeriod,
      category: category ?? this.category,
      amount: amount ?? this.amount,
    );
  }

  Contract copyWithAmount({int? amount}) {
    return Contract(
      id: id,
      description: description,
      billingPeriod: billingPeriod,
      category: category,
      amount: amount ?? this.amount,
    );
  }
}
