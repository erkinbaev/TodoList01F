import 'package:flutter/material.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/details/detail_page.dart';
import 'package:todo_app_01f/home/home_state.dart';
import 'package:todo_app_01f/home/home_view_model.dart';
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
    child: BlocConsumer<HomeCubit, HomeState>(
      listenWhen: (prev, curr) => prev.error != curr.error && curr.error != null,
      listener: (context, state) {
        // убрать предыдущий snackbar, чтобы не накапливались
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("Вы не написали название задачи!"),
        //   ),
        // );
        showAppSnackBar(context, text: "Вы не написали название задачи!", backgroundColor: Colors.green);
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

       return Scaffold(
         appBar: AppBar(
           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
           title: const Text("Todo List"),
           actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)  => SettingsPage(
                isDarkTheme: widget.isDarkTheme,
                onThemeChanged: widget.onThemeChanged,
              )));
            }, 
            icon: Icon(Icons.settings))
           ],
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
        //  onPressed: () => setValues(),
           child: const Icon(Icons.add),
         ),
       );
  
   },
   ),
 );
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
