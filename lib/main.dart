import 'package:flutter/material.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/home/home_page.dart';
import 'package:todo_app_01f/services/app_preferences.dart';
import 'package:todo_app_01f/todo_repository.dart';

late final AppDatabase database;
late final TodoRepository repository;
late final AppPreferences preferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();
  repository = TodoRepositoryImpl(database);
  preferences = AppPreferences.instance;
  await preferences.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  late bool isDarkTheme;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDarkTheme = preferences.isDarkTheme;
  }

  void changeTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
    preferences.setDarkTheme(value);
  } 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkTheme ? ThemeMode.dark : ThemeMode.light, 
      home:  MyHomePage(isDarkTheme: isDarkTheme, onThemeChanged: changeTheme),
    );
  }
}

