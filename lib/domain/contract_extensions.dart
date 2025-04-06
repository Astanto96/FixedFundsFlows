import 'package:fixedfundsflows/core/utils/billing_period.dart';
import 'package:fixedfundsflows/domain/contract.dart';
import 'package:flutter/material.dart';

extension BillingIconExtension on Contract {
  IconData get billingIcon {
    switch (billingPeriod) {
      case BillingPeriod.monthly:
        return Icons.calendar_month;
      case BillingPeriod.quarterly:
        return Icons.today;
      case BillingPeriod.yearly:
        return Icons.calendar_today;
    }
  }
}
