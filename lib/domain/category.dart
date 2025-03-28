class Category {
  int? id;
  String description;

  Category({this.id, required this.description});

  Category copyWith({
    int? id,
    String? description,
  }) {
    return Category(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
