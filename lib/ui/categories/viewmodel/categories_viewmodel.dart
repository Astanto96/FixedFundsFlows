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
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
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
