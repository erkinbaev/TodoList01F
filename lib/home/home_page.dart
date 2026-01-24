import 'package:flutter/material.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/home/home_state.dart';
import 'package:todo_app_01f/home/home_view_model.dart';
import 'package:todo_app_01f/main.dart';
import 'package:todo_app_01f/mock_database.dart';
import 'package:todo_app_01f/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

 
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // late final HomeCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
   // final todo = Todo(id: id, title: title, isFinished: isFinished, date: date)
  //  final db = MockDatabase();
  //  final repo = TodoRepositoryImpl(db);
  //  final vm = HomeViewModel(repo: repo);
  //  cubit = HomeCubit(vm: vm)..init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Todi List"),
      ),
      body: FutureBuilder(
        future: database.getTodoList(), 
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final todoList = snapshot.data;

          return ListView.builder(
            itemCount: todoList?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todoList![index].title),
              );
            }
            );
        }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => { 
            database.insertTodo(TodosCompanion.insert(title: "Test", date: DateTime.now().toString())),
            setState(() {
              
            })
          },
          child: const Icon(Icons.add),
          ),
    );
  }
}
