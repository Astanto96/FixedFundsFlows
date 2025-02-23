import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'box_providers.g.dart';

@riverpod
Future<Box<ContractHive>> contractBox(Ref ref) async {
  return await Hive.openBox<ContractHive>('contracts');
}

@riverpod
Future<Box<CategoryHive>> categoryBox(Ref ref) async {
  return await Hive.openBox<CategoryHive>('category');
}
