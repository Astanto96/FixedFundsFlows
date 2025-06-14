import 'package:fixedfundsflows/domain/category.dart';

class CategoriesState {
  final List<Category> categories;
  final bool isLoading;
  final String? error;

  CategoriesState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  CategoriesState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
    );
  }
}
