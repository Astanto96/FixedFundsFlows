import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/ui/categorys/viewmodel/categories_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'categories_viewmodel.g.dart';

@riverpod
class CategoriesViewmodel extends _$CategoriesViewmodel {
  late final CategoryRepository _repository;

  @override
  CategoriesState build() {
    _repository = ref.watch(categoryRepositoryProvider);
    return CategoriesState();
  }

  Future<void> loadCategories() async {
    state = state.copyWith(isLoading: true);

    try {
      final categories = await _repository.getCategories();
      state = state.copyWith(categories: categories, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
