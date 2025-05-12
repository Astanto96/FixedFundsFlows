import 'package:fixedfundsflows/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

enum BillingPeriod { monthly, quarterly, yearly }

extension BillingPeriodLabel on BillingPeriod {
  String label(AppLocalizations loc) {
    return loc.billingLabel(this);
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
