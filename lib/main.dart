import 'package:fixedfundsflows/core/utils/observer.dart';
import 'package:fixedfundsflows/data/models/billing_period_hive.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:fixedfundsflows/fixedfundsflowsapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(CategoryHiveAdapter());
  Hive.registerAdapter(ContractHiveAdapter());
  Hive.registerAdapter(BillingPeriodHiveAdapter());

  await Hive.openBox<CategoryHive>('categories');
  await Hive.openBox<ContractHive>('contracts');

  await _addDummyData();

  runApp(
    ProviderScope(
      observers: [MyObserver()],
      child: const FixedFundsFlowsApp(),
    ),
  );
}

Future<void> _addDummyData() async {
  final categoryBox = Hive.box<CategoryHive>('categories');
  final contractBox = Hive.box<ContractHive>('contracts');

  if (categoryBox.isEmpty && contractBox.isEmpty) {
    for (int i = 0; i <= 5; i++) {
      final catID =
          await categoryBox.add(CategoryHive(description: 'Category$i'));

      await contractBox.add(
        ContractHive(
          description: 'Vertrag $i',
          billingPeriod: BillingPeriodHive.monthly,
          categoryId: catID,
          amount: 4000 * i,
        ),
      );
    }

    await contractBox.add(
      ContractHive(
        description: 'KFZ - Vers.',
        billingPeriod: BillingPeriodHive.yearly,
        categoryId:
            await categoryBox.add(CategoryHive(description: 'Versicherung')),
        amount: 17000,
      ),
    );
  }
}
