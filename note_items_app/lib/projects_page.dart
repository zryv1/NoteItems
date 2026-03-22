import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key, required this.title});
  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  void openProjectCreateWindow() {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text("Новый проект"),
          content: TextField(
            decoration: InputDecoration(
              labelText: "Название проекта",
              border: UnderlineInputBorder(),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(buildContext),
              child: Text("Создать"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(buildContext),
              child: Text("Отмена"),
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
        onPressed: openProjectCreateWindow,
        child: const Icon(Icons.add),
      ),
    );
  }
}