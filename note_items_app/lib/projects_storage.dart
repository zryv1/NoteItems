import 'models/project_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

// TODO Временное решение

class ProjectsStorage {

  final projects = Hive.box<Project>("projects");

  Project createProject(String projectName) {
    final idBox = Hive.box<int>("id");
    final id = idBox.get("id", defaultValue: 0);
    final projectId = id.toString();
    final Project project = Project(id: projectId, name: projectName);
    final nextId = id! + 1;
    idBox.put("id", nextId);
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
}
