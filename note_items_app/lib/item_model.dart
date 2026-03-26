import 'dart:ffi';

class Item {
  final String name;
  final String pathToIcon;
  final String? description;
  final Float cord_x;
  final Float cord_y;

  Item({
    required this.name,
    required this.pathToIcon,
    this.description,
    required this.cord_x,
    required this.cord_y
  });
}
