import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'box_providers.g.dart';

@riverpod
Box<ContractHive> contractBox(Ref ref) {
  return Hive.box<ContractHive>('contracts');
}

@riverpod
Box<CategoryHive> categoryBox(Ref ref) {
  return Hive.box<CategoryHive>('categories');
}
