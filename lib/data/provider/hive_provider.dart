import 'package:fixedfundsflows/data/models/billing_period_hive.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hive_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> hiveInit(Ref ref) async {
  if (!Hive.isBoxOpen('categories')) {
    await Hive.openBox<CategoryHive>('categories');
  }

  if (!Hive.isBoxOpen('contracts')) {
    await Hive.openBox<ContractHive>('contracts');
  }
  await _addDummyData();
}

//mit "flutter clean" können die Hive-Daten gelöscht werden
/// Fügt Dummy-Daten hinzu, falls die Hive-Boxen leer sind.
Future<void> _addDummyData() async {
  final categoryBox = Hive.box<CategoryHive>('categories');
  final contractBox = Hive.box<ContractHive>('contracts');

  if (categoryBox.isNotEmpty || contractBox.isNotEmpty) return;
  await contractBox.add(
    ContractHive(
      description: 'Car Insurance',
      billingPeriod: BillingPeriodHive.yearly,
      categoryId: await categoryBox.add(CategoryHive(description: 'Insurance')),
      amount: 17000,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Rent',
      billingPeriod: BillingPeriodHive.monthly,
      categoryId: await categoryBox.add(CategoryHive(description: 'Housing')),
      amount: 85000,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Mobile Contract',
      billingPeriod: BillingPeriodHive.monthly,
      categoryId:
          await categoryBox.add(CategoryHive(description: 'Communication')),
      amount: 3000,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Netflix Subscription',
      billingPeriod: BillingPeriodHive.monthly,
      categoryId:
          await categoryBox.add(CategoryHive(description: 'Entertainment')),
      amount: 1299,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Spotify Premium',
      billingPeriod: BillingPeriodHive.monthly,
      categoryId: await categoryBox.add(CategoryHive(description: 'Music')),
      amount: 999,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Gym Membership',
      billingPeriod: BillingPeriodHive.monthly,
      categoryId: await categoryBox.add(CategoryHive(description: 'Health')),
      amount: 4500,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Internet',
      billingPeriod: BillingPeriodHive.monthly,
      categoryId:
          await categoryBox.add(CategoryHive(description: 'Communication')),
      amount: 3999,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Amazon Prime',
      billingPeriod: BillingPeriodHive.yearly,
      categoryId:
          await categoryBox.add(CategoryHive(description: 'Entertainment')),
      amount: 8999,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Public Transport Ticket',
      billingPeriod: BillingPeriodHive.monthly,
      categoryId: await categoryBox.add(CategoryHive(description: 'Transport')),
      amount: 4900,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Liability Insurance',
      billingPeriod: BillingPeriodHive.yearly,
      categoryId: await categoryBox.add(CategoryHive(description: 'Insurance')),
      amount: 6000,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Electricity Costs',
      billingPeriod: BillingPeriodHive.monthly,
      categoryId: await categoryBox.add(CategoryHive(description: 'Housing')),
      amount: 7500,
    ),
  );

  await contractBox.add(
    ContractHive(
      description: 'Broadcasting Fees',
      billingPeriod: BillingPeriodHive.quarterly,
      categoryId: await categoryBox.add(CategoryHive(description: 'Taxes')),
      amount: 5586,
    ),
  );
}
