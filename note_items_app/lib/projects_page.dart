import 'package:flutter/material.dart';
import 'models/project_model.dart';
import 'projects_storage.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key, required this.title});
  final String title;

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final projectsStorage = ProjectsStorage();
  late List<Widget> projectsAsButtonList;

  Project _createProject(String projectName) {
    final Project project = this.projectsStorage.createProject(projectName);
    return project;
  }

  void _addProjectToStorage(Project project) {
    this.projectsStorage.addProjectToStorage(project);
  }

  void _deleteProjectFromStorage(Project project) {
    this.projectsStorage.deleteProjectFromStorage(project);
  }

  AlertDialog _getProjectCreationWindow(BuildContext context) {
    final controller = TextEditingController();
    final alertDialog = AlertDialog(
      title: Text("Новый проект"),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: "Название проекта",
          border: UnderlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
            child: Text("Создать"),
            onPressed: () {
              final projectName = controller.text;
              if (projectName.isNotEmpty) {
                final project = _createProject(projectName);
                _addProjectToStorage(project);
                Navigator.pop(context);
                setState(() {});
              }
            },
        ),
        TextButton(
            child: Text("Отмена"),
            onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    return alertDialog;
  }

  void openProjectCreationWindow() {
    showDialog(
      context: context,
      builder: (BuildContext context) => _getProjectCreationWindow(context),
    );
  }
  
  List<Widget> getNewProjectsAsButtonList() {
    final Map<dynamic, Project> projectsAsMap = projectsStorage.getProjects();
    final List<Widget> projectsAsButtonList = [];
    for (var project in projectsAsMap.values) {
      final key = UniqueKey();
      final button = Material(
        key: key,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/floors", arguments: project);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text("${project.name}"),
                ),
                IconButton(
                  onPressed: () {
                    _deleteProjectFromStorage(project);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      );
      projectsAsButtonList.add(button);
    }
    return projectsAsButtonList;
  }

  @override
  Widget build(BuildContext context) {
    this.projectsAsButtonList = this.getNewProjectsAsButtonList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => openProjectCreationWindow(),
            child: Text("Создать проект"),
          ),
          Expanded(
            child: ListView(
              children: projectsAsButtonList,
            ),
          ),
        ],
      ),
    );
  }
}
