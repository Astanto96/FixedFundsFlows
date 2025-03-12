import 'package:fixedfundsflows/data/models/billing_period_hive.dart';
import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hive_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> hiveInit(Ref ref) async {
  print("📦 [Hive] Starte Initialisierung...");

  if (!Hive.isBoxOpen('categories')) {
    final catBox = await Hive.openBox<CategoryHive>('categories');
    print("✅ [Hive] 'categories' Box geöffnet | Einträge: ${catBox.length}");
    _printBoxContents(catBox);
  }

  if (!Hive.isBoxOpen('contracts')) {
    final contractBox = await Hive.openBox<ContractHive>('contracts');
    print(
        "✅ [Hive] 'contracts' Box geöffnet | Einträge: ${contractBox.length}");
    _printBoxContents(contractBox);
  }
  await _addDummyData();

  print("✅ [Hive] Alle Boxen erfolgreich initialisiert!");
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
  } else {
    print("⚡ [Hive] Daten bereits vorhanden, keine Dummy-Daten hinzugefügt.");
  }
  print(
    "📦 [Hive] Endgültiger Stand - Kategorien: ${categoryBox.length}, Verträge: ${contractBox.length}",
  );
  printHiveData();
}

void _printBoxContents(Box<dynamic> box) {
  print("📂 [Hive] Inhalte der Box '${box.name}':");
  for (int i = 0; i < box.length; i++) {
    final entry = box.getAt(i);
    print("🔹 Eintrag [$i]: $entry");
  }
}

void printHiveData() {
  final categoryBox = Hive.box<CategoryHive>('categories');
  final contractBox = Hive.box<ContractHive>('contracts');

  print("📦 [Hive] Anzahl gespeicherter Kategorien: ${categoryBox.length}");
  print("📦 [Hive] Anzahl gespeicherter Verträge: ${contractBox.length}");

  print("\n📂 [Hive] Kategorien:");
  for (int i = 0; i < categoryBox.length; i++) {
    final category = categoryBox.getAt(i);
    print("📂 ID: ${categoryBox.keyAt(i)}, Name: ${category?.description}");
  }

  print("\n📂 [Hive] Verträge:");
  for (int i = 0; i < contractBox.length; i++) {
    final contract = contractBox.getAt(i);
    print(
        "📂 ID: ${contractBox.keyAt(i)}, Beschreibung: ${contract?.description}, Betrag: ${contract?.amount}, Kategorie-ID: ${contract?.categoryId}, Zeitraum: ${contract?.billingPeriod}");
  }
}
