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
  late List<Widget> projectsAsButtonList = getNewProjectsAsButtonList();

  // TODO projects должен лежать в Hive, чтобы расположение не сбрасывалось при перезаходе(или придумать что нибудь другое)

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
              final project = _createProject(projectName);
              _addProjectToStorage(project);
              Navigator.pop(context);
              setState(() {
                this.projectsAsButtonList = this.getNewProjectsAsButtonList();
                print(this.projectsAsButtonList);
              });
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

  void _moveItemsInList(int oldIndex, int newIndex) {
    final temp = this.projectsAsButtonList[oldIndex];
    int index;
    final int outIndex;
    final List<Widget> projects;
    if (oldIndex > newIndex) {
      index = newIndex;
      outIndex = oldIndex;
      projects = this.projectsAsButtonList.sublist(index, outIndex);
      this.projectsAsButtonList.replaceRange(index+1, outIndex+1, projects);
      this.projectsAsButtonList[newIndex] = temp;
    } else {
      index = oldIndex+1;
      outIndex = newIndex;
      projects = this.projectsAsButtonList.sublist(index, outIndex);
      this.projectsAsButtonList.replaceRange(index-1, outIndex-1, projects);
      this.projectsAsButtonList[newIndex-1] = temp;
    }
  }
  
  List<Widget> getNewProjectsAsButtonList() {
    final Map<dynamic, Project> projectsAsMap = projectsStorage.getProjects ();
    final List<Widget> projectsAsButtonList = [];
    for (var project in projectsAsMap.values) {
      final key = UniqueKey();
      final button = Material(
        key: key,
        child: InkWell(
          onTap: () {

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
                    setState(() {
                      this.projectsAsButtonList = this.getNewProjectsAsButtonList();
                    });
                    print(this.projectsAsButtonList);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView(
            onReorder: (oldIndex, newIndex) => _moveItemsInList(oldIndex, newIndex),
            children: projectsAsButtonList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openProjectCreationWindow(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
