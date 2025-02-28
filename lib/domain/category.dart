class Category {
  int id;
  String description;

  Category({required this.id, required this.description});

  Category copyWith({
    int? id,
    String? description,
  }) {
    return Category(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
}
