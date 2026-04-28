import 'models/project_model.dart';
import 'models/floor_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

// TODO Временное решение

class ProjectsStorage {

  final projects = Hive.box<Project>("projects");

  String getIdForProject() {
    final idBox = Hive.box<int>("projectId");
    final id = idBox.get("id", defaultValue: 0) as int;
    idBox.put("id", id + 1);

    return id.toString();
  }

  Project createProject(String projectName) {
    final id = getIdForProject();
    final Project project = Project(id: id, name: projectName);
    return project;
  }

  void addProjectToStorage(Project project) async {
    await this.projects.put(project.id, project);
  }

  void deleteProjectFromStorage(Project project) async {
    await this.projects.delete(project.id);
  }

  Map<dynamic, Project> getProjects() {
    return this.projects.toMap();
  }

  String getIdForFloor() {
    final idBox = Hive.box<int>("floorId");
    final id = idBox.get("id", defaultValue: 0) as int;
    idBox.put("id", id + 1);

    return id.toString();
  }

  Floor createFloor(String floorNumber) {
    final id = getIdForFloor();
    final Floor floor = Floor(id: id, number: floorNumber, pathToImage: "None");

    return floor;
  }

  void addFloorToProject(Floor floor, String projectId) async {
    final projects = getProjects();
    Project project = projects[projectId]!;
    project.floors[floor.id] = floor;
    addProjectToStorage(project);
  }

  void deleteFloorFromProject(Floor floor, String projectId) async {
    final projects = getProjects();
    Project project = projects[projectId]!;
    project.floors.remove(floor.id);
    addProjectToStorage(project);
  }

  Map<String, Floor> getFloors(String projectId) {
    final projects = getProjects();
    Project project = projects[projectId]!;
    final floors = project.floors;
    return floors;
  }
}
