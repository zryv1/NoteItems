import 'item_model.dart';
import 'package:hive/hive.dart';

part 'floor_model.g.dart';

@HiveType(typeId: 1)
class Floor {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String number;
  @HiveField(2)
  final String pathToImage;
  @HiveField(3)
  final Map<String, Item> items; // itemID: Item

  Floor({
    required this.id,
    required this.number,
    required this.pathToImage,
    Map<String, Item>? items,
  }) : items = items ?? {}; 
}
