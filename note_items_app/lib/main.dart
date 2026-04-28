import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_items/models/project_model.dart';
import 'package:note_items/models/floor_model.dart';
import 'package:note_items/models/item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'auth_page.dart';
import 'projects_page.dart';
import 'floors_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Hive.init('storage');
  } else {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  Hive.registerAdapter(ProjectAdapter());
  Hive.registerAdapter(FloorAdapter());
  Hive.registerAdapter(ItemAdapter());

  await Hive.openBox<Project>("projects");
  await Hive.openBox<int>("projectId");
  await Hive.openBox<int>("floorId");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: "/auth",
      routes: {
        "/auth": (context) => const AuthPage(title: "Страница авторизации"),
        "/projects": (context) => ProjectsPage(title: "Мои проекты"),
        "/floors": (context) => FloorsPage(title: "Название проекта"),
      },
    );
  }
}
