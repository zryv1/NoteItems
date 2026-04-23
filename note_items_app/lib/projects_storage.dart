import 'models/project_model.dart';
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
}
