import 'dart:ffi';
import 'item_model.dart';

class Floor {
  final String pathToImage;
  final Map<Int, Item> items; // itemID: Item

  Floor({
    required this.pathToImage,
    required this.items
  });
}
