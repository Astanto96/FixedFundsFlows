import 'package:fixedfundsflows/data/models/category_hive.dart';
import 'package:fixedfundsflows/data/models/contract_hive.dart';

class BackupDataDto {
  final List<ContractHive> contracts;
  final List<CategoryHive> categories;

  BackupDataDto({
    required this.contracts,
    required this.categories,
  });

  factory BackupDataDto.fromJson(Map<String, dynamic> json) {
    return BackupDataDto(
      contracts: (json['contracts'] as List<dynamic>)
          .map((e) => ContractHive.fromJson(
              Map<String, dynamic>.from(e as Map<String, dynamic>)))
          .toList(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryHive.fromJson(
              Map<String, dynamic>.from(e as Map<String, dynamic>)))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'contracts': contracts.map((c) => c.toJson()).toList(),
      'categories': categories.map((c) => c.toJson()).toList(),
    };
  }
}
