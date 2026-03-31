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

  late final projects = getProjectsAsButtonList();

  // TODO projects должен лежать в Hive, чтобы расположение не сбрасывалось при перезаходе(или придумать что нибудь другое)
  // TODO Проследить, чтобы при добавлении нового проекта список на экране обновлялся

  void openProjectCreateWindow() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
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
                  final project = ProjectsStorage().createProject(projectName);
                  ProjectsStorage().addProjectToStorage(project);
                  Navigator.pop(buildContext);
                  setState(() {});
                }
              },
            ),
            TextButton(
              child: Text("Отмена"),
              onPressed: () {Navigator.pop(buildContext);},
            ),
          ],
        );
      },
    );
  }

  List<Project> getProjectsAsList() {
    final projects = ProjectsStorage().getProjectsAsList();
    return projects;
  }

  List<TextButton> convertProjectListToButtonProjectList() {
    final projects = getProjectsAsList();
    List<TextButton> buttonsList = [];
    for (var project in projects) {
      final button = TextButton(
        key: UniqueKey(),
        onPressed: () {},
        child: Text("${project.id}: ${project.name}"),
      );
      buttonsList.add(button);
    }
    return buttonsList;
  }

  List<TextButton> getProjectsAsButtonList() {
    final projects = convertProjectListToButtonProjectList();
    return projects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ReorderableListView(
            onReorder: (oldIndex, newIndex) {
              final TextButton temp = projects[oldIndex];
              int index;
              final int outIndex;
              final List<TextButton> proj;
              if (oldIndex > newIndex) {
                index = newIndex;
                outIndex = oldIndex;
                proj = projects.sublist(index, outIndex);
                projects.replaceRange(index+1, outIndex+1, proj);
                projects[newIndex] = temp;
              } else {
                index = oldIndex+1;
                outIndex = newIndex;
                proj = projects.sublist(index, outIndex);
                projects.replaceRange(index-1, outIndex-1, proj);
                projects[newIndex-1] = temp;
              }
            },
            children: projects,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openProjectCreateWindow();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
