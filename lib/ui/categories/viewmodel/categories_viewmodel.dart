import 'package:fixedfundsflows/core/utils/category_color_manager.dart';
import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/data/repositories/contract_repository.dart';
import 'package:fixedfundsflows/ui/categories/viewmodel/categories_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_viewmodel.g.dart';

@riverpod
class CategoriesViewmodel extends _$CategoriesViewmodel {
  late final CategoryRepository _catRepo;
  late final ContractRepository _conRepo;

  @override
  CategoriesState build() {
    _catRepo = ref.watch(categoryRepositoryProvider);
    _conRepo = ref.watch(contractRepositoryProvider);
    return CategoriesState();
  }

  Future<void> loadCategories() async {
    state = state.copyWith(isLoading: true);

    try {
      final categories = await _catRepo.getCategories();
      state = state.copyWith(categories: categories, isLoading: false);
      // Update the category color manager with the new categories
      ref.read(categoryColorManagerProvider).updateCategories(
          categories.where((e) => e.id != null).map((e) => e.id!).toList());
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clearError() {
    if (state.error != null) {
      // ignore: avoid_redundant_argument_values

      state = state.copyWith(clearError: true);
    }
  }

  Future<bool> deleteCategory(int key) async {
    final isInUse = await _conRepo.isCategoryInUse(key);
    if (isInUse) {
      return false;
    } else {
      _catRepo.deleteCategory(key);
      loadCategories();
      return true;
    }
  }
}
