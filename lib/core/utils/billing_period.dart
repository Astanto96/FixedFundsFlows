import 'package:flutter/material.dart';

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

extension BillingPeriodIcon on BillingPeriod {
  IconData get billingIcon {
    switch (this) {
      case BillingPeriod.monthly:
        return Icons.calendar_month;
      case BillingPeriod.quarterly:
        return Icons.today;
      case BillingPeriod.yearly:
        return Icons.calendar_today;
    }
  }
}
