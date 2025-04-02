class CategoryState {
  final bool isLoading;
  final String? error;
  final String? descriptionError;

  final int? id;
  final String description;

  CategoryState({
    this.isLoading = false,
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
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      descriptionError: descriptionError ?? this.descriptionError,
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
}
