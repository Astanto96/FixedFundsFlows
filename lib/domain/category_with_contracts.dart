import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/domain/contract.dart';

class CategoryWithContracts {
  final Category category;
  final List<Contract> contracts;
  final int? totalAmount;
  final int? contractCount;

  CategoryWithContracts({
    required this.category,
    this.contracts = const [],
    this.totalAmount,
    this.contractCount,
  });

  CategoryWithContracts copyWith({
    Category? category,
    List<Contract>? contracts,
    int? totalAmount,
    int? contractCount,
  }) {
    return CategoryWithContracts(
      category: category ?? this.category,
      contracts: contracts ?? this.contracts,
      totalAmount: totalAmount ?? this.totalAmount,
      contractCount: contractCount ?? this.contractCount,
    );
  }
}
