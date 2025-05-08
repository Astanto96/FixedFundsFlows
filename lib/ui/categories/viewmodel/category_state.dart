class CategoryState {
  final bool isLoading;
  final String? error;
  final String? descriptionError;
  final bool isMaxCategoriesReached;

  final int? id;
  final String description;

  CategoryState({
    this.isLoading = false,
    this.isMaxCategoriesReached = false,
    this.error,
    this.descriptionError,
    this.id,
    this.description = '',
  });
  CategoryState copyWith({
    bool? isLoading,
    String? error,
    String? descriptionError,
    int? id,
    String? description,
    bool? isMaxCategoriesReached,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      descriptionError: descriptionError ?? this.descriptionError,
      isMaxCategoriesReached:
          isMaxCategoriesReached ?? this.isMaxCategoriesReached,
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
}
