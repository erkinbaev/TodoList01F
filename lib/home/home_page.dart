import 'package:flutter/material.dart';
import 'package:todo_app_01f/add/add_page.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/details/detail_page.dart';
import 'package:todo_app_01f/home/home_state.dart';
import 'package:todo_app_01f/home/home_view_model.dart';
import 'package:todo_app_01f/home/todo_tile.dart';
import 'package:todo_app_01f/main.dart';
import 'package:todo_app_01f/settings/settings_page.dart';
import 'package:todo_app_01f/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
final bool isDarkTheme;
  final ValueChanged<bool> onThemeChanged;

  const MyHomePage({super.key, required this.isDarkTheme, required this.onThemeChanged});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HomeCubit cubit;
  late SharedPreferences prefs;
  


  @override
  void initState() {
    // TODO: implement initState
   // final todo = Todo(id: id, title: title, isFinished: isFinished, date: date)
  //  final db = MockDatabase();
  //  final repo = TodoRepositoryImpl(db);
    final vm = HomeViewModel(repo: repository);
    cubit = HomeCubit(vm: vm)..init();
    loadValue();
  }

  Future<void> loadValue() async {
    prefs = await SharedPreferences.getInstance();

    print(prefs.getBool('isDarkTheme'));
    print(prefs.getInt('progress'));
    print(prefs.getString('username'));
  }

  Future<void> setValues() async {
    prefs = await SharedPreferences.getInstance();

    prefs.setBool('isDarkTheme', false);
    prefs.setInt('progress', 60);
    prefs.setString('username', 'Nursultan');
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
        body: SafeArea(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Мои задачи',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Container(height: 1, color: Colors.black26),
              const SizedBox(height: 18),

              Expanded(
                child: ListView.separated(
                  itemCount: state.items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final todoItem = state.items[index];
                    return TodoTile(
                      title: todoItem.title, 
                      dateText: todoItem.date, 
                      isDone: todoItem.isFinished, 
                      onChanged: (v) {
                       // setState(() => todoItem.isFinished = v;
                      }
                      );
                  },
                )
                ),
                const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    _navigateToAddPage(context);
                  },
                  icon: const Icon(Icons.add, size: 26),
                  label: const Text(
                    'Добавить задачу',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A72FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          )
          ),
       );
  
   },
   ),
 );
}

void _navigateToAddPage(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddPage()));
}

void showAppSnackBar(
  BuildContext context, {
  required String text,
  Color? backgroundColor,
  IconData? icon,
  VoidCallback? onRetry,
  String retryText = "Повторить",
}) {
  final messenger = ScaffoldMessenger.of(context);

  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
          ],
          Expanded(child: Text(text)),
        ],
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      duration: const Duration(seconds: 3),
      action: onRetry == null
          ? null
          : SnackBarAction(
              label: retryText,
              onPressed: onRetry,
              textColor: Colors.white,
            ),
    ),
  );
}

}
