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
