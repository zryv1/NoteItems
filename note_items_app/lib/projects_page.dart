import 'package:flutter/material.dart';
import 'projects_storage.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key, required this.title});
  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  void openProjectCreateWindow() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text("Новый проект"),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Название проекта",
              border: UnderlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Создать"),
              onPressed: () {
                final projectName = _controller.text;
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

  List<Widget> getProjects() {
    final projects = ProjectsStorage().getProjects();
    List<Widget> project_list = [];
    for (var value in projects.values) {
      final project_name = value.name;
      print("$project_name, ${value.id}");
      final button = TextButton(
        child: Text(project_name),
        onPressed: () {},
      );
      project_list.add(button);
    }
    return project_list;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: getProjects(),
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
