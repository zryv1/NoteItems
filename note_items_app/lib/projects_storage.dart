import 'models/project_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProjectsStorage {

  Project createProject(String projectName) {
    // Временное решение с использованием int значения для id
    final idBox = Hive.box<int>("id");
    final id = idBox.get("id", defaultValue: 0);
    final project_id = id.toString();
    final Project project = Project(id: project_id, name: projectName);
    idBox.put("id", id! + 1);
    return project;
  }
  
  void addProjectToStorage(Project project) async {
    final projects = Hive.box<Project>("projects");
    await projects.put(project.id, project);
  }

  Box<Project> getProjects() {
    final projects = Hive.box<Project>("projects");
    return projects;
  }
}
