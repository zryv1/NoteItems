import 'package:hive/hive.dart';
import 'floor_model.dart';

part 'project_model.g.dart';

@HiveType(typeId: 0)
class Project {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final Map<String, Floor>? floors; // floorNumber: Floor

  Project({
    required this.id,
    required this.name,
    this.floors
  });
}
