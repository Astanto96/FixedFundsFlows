// ignore_for_file: avoid_classes_with_only_static_members

import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/data/models/billing_period_hive.dart';

class BillingPeriodMapper {
  static BillingPeriodHive toHive(BillingPeriod domainEnum) {
    switch (domainEnum) {
      case BillingPeriod.monthly:
        return BillingPeriodHive.monthly;
      case BillingPeriod.quarterly:
        return BillingPeriodHive.quarterly;
      case BillingPeriod.yearly:
        return BillingPeriodHive.yearly;
    }
  }

  static BillingPeriod toDomain(BillingPeriodHive hiveEnum) {
    switch (hiveEnum) {
      case BillingPeriodHive.monthly:
        return BillingPeriod.monthly;
      case BillingPeriodHive.quarterly:
        return BillingPeriod.quarterly;
      case BillingPeriodHive.yearly:
        return BillingPeriod.yearly;
    }
  }
}
