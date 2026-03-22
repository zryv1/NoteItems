import 'package:flutter/material.dart';
import 'package:note_items/auth_page.dart';
import 'package:note_items/projects_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: "/",
      routes: {
        "/": (context) => const AuthPage(title: "Страница авторизации"),
        "/projects": (context) => const FirstPage(title: "Мои проекты"),
      },
    );
  }
}
