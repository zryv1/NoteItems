import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:note_items/auth_page.dart';
import 'package:note_items/projects_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Hive.init('hive_storage');
  } else {
    // Для Android/iOS используем путь к документам приложения
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  await Hive.openBox('projects');

  runApp(MyApp());
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
        "/projects": (context) => FirstPage(title: "Мои проекты"),
      },
    );
  }
}
