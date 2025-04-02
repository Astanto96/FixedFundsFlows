import 'package:fixedfundsflows/data/repositories/category_repository.dart';
import 'package:fixedfundsflows/domain/category.dart';
import 'package:fixedfundsflows/ui/categorys/viewmodel/category_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_viewmodel.g.dart';

@riverpod
class CategoryViewModel extends _$CategoryViewModel {
  late final CategoryRepository _categoryRepo;

  @override
  CategoryState build() {
    _categoryRepo = ref.watch(categoryRepositoryProvider);
    return CategoryState();
  }

  //Validation -----------------------------------------------
  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    return null;
  }

  bool validateForm() {
    final descriptionError = validateDescription(state.description);

    // Update state with validation errors
    state = state.copyWith(
      descriptionError: descriptionError,
    );

    // Form is valid if there are no errors
    return descriptionError == null;
  }

  //Updating -----------------------------------------
  void updateDescription(String value) {
    state = state.copyWith(
      description: value,
      descriptionError: validateDescription(value),
    );
  }

  Future<bool> saveCategory() async {
    if (!validateForm()) {
      return false;
    }

    state = state.copyWith(isLoading: true);

    try {
      await _categoryRepo.addCategory(
        Category(
          description: state.description,
        ),
      );
      return true;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
