import 'package:flutter/material.dart';
import 'package:todo_app_01f/home/home_state.dart';
import 'package:todo_app_01f/home/home_view_model.dart';
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
  late final HomeCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
   // final todo = Todo(id: id, title: title, isFinished: isFinished, date: date)
   final db = MockDatabase();
   final repo = TodoRepositoryImpl(db);
   final vm = HomeViewModel(repo: repo);
   cubit = HomeCubit(vm: vm)..init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              print("Показываете лоудер");
            }

            if (state.error != null) {
              print(state.error.toString());
            }

            if (state.items.isEmpty) {
              return Text("список пуст");
            }

            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final todo = state.items[index];
                return ListTile(
                  title: Text(todo.title),
                );
              }
              );
          },
        )
      ),
      );
  }
}
