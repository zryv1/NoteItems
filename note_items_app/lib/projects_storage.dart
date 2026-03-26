import 'project_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProjectsStorage {

  Project createProject(String projectName) {
    final Project project = Project(name: projectName);
    return project;
  }
  
  void addProjectToStorage(Project project) async {
    final projects = Hive.box("projects");
    await projects.put(project.name, project);
    projects.close();
  }
}
