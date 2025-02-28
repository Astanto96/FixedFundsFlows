import 'package:fixedfundsflows/domain/category.dart';
import 'package:hive/hive.dart';

part 'category_hive.g.dart';

@HiveType(typeId: 0)
class CategoryHive extends HiveObject {
  @HiveField(0)
  String description;

  CategoryHive({required this.description});

  factory CategoryHive.fromDomain(Category category) {
    return CategoryHive(description: category.description);
  }

  Category toDomain() {
    return Category(id: key as int, description: description);
  }
}
