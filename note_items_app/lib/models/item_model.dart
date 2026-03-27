import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 2)
class Item {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String pathToIcon;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final double cord_x;
  @HiveField(5)
  final double cord_y;

  Item({
    required this.id,
    required this.name,
    required this.pathToIcon,
    this.description,
    required this.cord_x,
    required this.cord_y
  });
}
