import 'package:flutter/material.dart';
import 'models/project_model.dart';

class FloorsPage extends StatefulWidget {
  const FloorsPage({super.key, required this.title});
  final String title;

  @override
  State<FloorsPage> createState() => _FloorsPageState();
}

class _FloorsPageState extends State<FloorsPage> {

  @override
  Widget build(BuildContext context) {
    final project = ModalRoute.of(context)!.settings.arguments as Project;
    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
      ),
      body: Column(
        children: [
          Center(child: Text("Будет добавлено позже"),),
        ],
      ),
    );
  }
}
