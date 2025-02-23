import 'package:hive/hive.dart';

part 'category_hive.g.dart';

@HiveType(typeId: 0)
class CategoryHive extends HiveObject {
  @HiveField(0)
  String description;

  CategoryHive({required this.description});
}
