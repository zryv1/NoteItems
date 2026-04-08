import 'package:flutter/material.dart';
import 'models/project_model.dart';
import 'projects_storage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key, required this.title});
  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final projectsStorage = ProjectsStorage();
  late final projectsAsButtonList = getProjectsAsButtonList();

  // TODO projects должен лежать в Hive, чтобы расположение не сбрасывалось при перезаходе(или придумать что нибудь другое)
  // TODO Проследить, чтобы при добавлении нового проекта список на экране обновлялся

  Project _createProject(String projectName) {
    final Project project = projectsStorage.createProject(projectName);
    return project;
  }

  void _addProjectToStorage(project) {
    projectsStorage.addProjectToStorage(project);
  }

  void _deleteProjectFromStorage(project) {

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
              setState(() {});
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

  void _moveItemsInList(oldIndex, newIndex) {
    final TextButton temp = projectsAsButtonList[oldIndex];
    int index;
    final int outIndex;
    final List<TextButton> proj;
    if (oldIndex > newIndex) {
      index = newIndex;
      outIndex = oldIndex;
      proj = projectsAsButtonList.sublist(index, outIndex);
      projectsAsButtonList.replaceRange(index+1, outIndex+1, proj);
      projectsAsButtonList[newIndex] = temp;
    } else {
      index = oldIndex+1;
      outIndex = newIndex;
      proj = projectsAsButtonList.sublist(index, outIndex);
      projectsAsButtonList.replaceRange(index-1, outIndex-1, proj);
      projectsAsButtonList[newIndex-1] = temp;
    }
  }

  List<Project> getProjectsAsList() {
    final Map<dynamic, Project> projectsAsMap = projectsStorage.getProjects();
    final List<Project> projectsAsList = [];
    for (var project in projectsAsMap.values) {
      projectsAsList.add(project);
    }
    return projectsAsList;
  }

  List<TextButton> getProjectsAsButtonList() {
    final Map<dynamic, Project> projectsAsMap = projectsStorage.getProjects();
    List<TextButton> projectsAsButtonList = [];
    for (var project in projectsAsMap.values) {
      final button = TextButton(
        key: UniqueKey(),
        onPressed: () {},
        child: Text("${project.name}"),
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
            onReorder: (oldIndex, newIndex) {_moveItemsInList(oldIndex, newIndex);},
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
