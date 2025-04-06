enum BillingPeriod { monthly, quarterly, yearly }

extension BillingPeriodLabel on BillingPeriod {
  String get label {
    switch (this) {
      case BillingPeriod.monthly:
        return 'Monthly';
      case BillingPeriod.quarterly:
        return 'Quarterly';
      case BillingPeriod.yearly:
        return 'Yearly';
    }
  }
}
