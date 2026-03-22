import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});
  final String title;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

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
            Text("Не авторизован"),
            ElevatedButton(
              onPressed: () {Navigator.popAndPushNamed(context, "/projects");},
              child: Text("Авторизоваться"),
            ),
          ],
        ),
      ),
    );
  }
}