import 'dart:ffi';
import 'floor_model.dart';

class Project {
  final String name;
  final Map<Int, Floor>? floors; // floorNumber: Floor

  Project({
    required this.name,
    this.floors
  });
}
