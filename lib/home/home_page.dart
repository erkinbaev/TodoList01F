import 'package:flutter/material.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/details/detail_page.dart';
import 'package:todo_app_01f/home/home_state.dart';
import 'package:todo_app_01f/home/home_view_model.dart';
import 'package:todo_app_01f/main.dart';
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
  //  final db = MockDatabase();
  //  final repo = TodoRepositoryImpl(db);
    final vm = HomeViewModel(repo: repository);
    cubit = HomeCubit(vm: vm)..init();
  }

  @override
Widget build(BuildContext context) {
 return BlocProvider.value(
   value: cubit,
   child: BlocBuilder<HomeCubit, HomeState>(
     builder: (context, state) {
       if (state.isLoading) {
         return const Scaffold(
           body: Center(child: CircularProgressIndicator()),
         );
       }


       if (state.error != null) {
         return Scaffold(
           appBar: AppBar(title: const Text("Todo List")),
           body: Center(child: Text("Ошибка: ${state.error}")),
         );
       }


       return Scaffold(
         appBar: AppBar(
           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
           title: const Text("Todo List"),
         ),
         body: ListView.builder(
           itemCount: state.items.length,
           itemBuilder: (context, index) {
             final item = state.items[index];
             return ListTile(
              title: Text(item.title),
              onTap: () async {
                    final bool? needRefresh = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(todo: item),
                      ),
                    );
                    if (needRefresh == true) {
                      setState(() {
                        cubit.init();
                      });
                    }
                  },
              );
           },
         ),
         floatingActionButton: FloatingActionButton(
           onPressed: () => context.read<HomeCubit>().addTest(),
           child: const Icon(Icons.add),
         ),
       );
  
   },
   ),
 );
}
}
