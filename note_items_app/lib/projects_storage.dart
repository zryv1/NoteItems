import 'models/project_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProjectsStorage {

  Project createProject(String projectName) {
    // Временное решение с использованием int значения для id
    final projects = Hive.box<Project>("projects");
    String id;

    if (projects.isNotEmpty) {
      id = (int.parse(
          projects.get(projects.keys.last)!.id
      ) + 1
      ).toString();
    } else {
      id = "0";
    }

    final Project project = Project(id: id, name: projectName);
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
