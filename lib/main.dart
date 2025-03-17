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

  runApp(
    ProviderScope(
      observers: [MyObserver()],
      child: const FixedFundsFlowsApp(),
    ),
  );
}
