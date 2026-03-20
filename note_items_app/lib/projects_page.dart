import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key, required this.title});
  final String title;

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

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
            // TODO Добавить динамический поиск
            // TODO Добавить кнопку "Cоздать проект"
            // TODO Добавить список созданных проектов
          ],
        ),
      ),
    );
  }
}