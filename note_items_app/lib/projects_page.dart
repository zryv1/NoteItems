import 'package:flutter/material.dart';
import 'projects_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openProjectCreateWindow();
          print(Hive.box("projects").keys);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
