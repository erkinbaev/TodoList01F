import 'package:flutter/material.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/home/home_page.dart';
import 'package:todo_app_01f/todo_repository.dart';

late final AppDatabase database;
late final TodoRepository repository;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = AppDatabase();
  repository = TodoRepositoryImpl(database);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

