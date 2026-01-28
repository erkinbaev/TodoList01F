
import 'package:todo_app_01f/database/app_database.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchList();
  Future<int> addTodo({required String title, required String date});
}

class TodoRepositoryImpl implements TodoRepository {
  //обертка над дазой данных
  final AppDatabase db;

  TodoRepositoryImpl(this.db);

  @override
  Future<int> addTodo({required String title, required String date}) => db.insertTodo(TodosCompanion.insert(title: title, date: date));

  @override
  Future<List<Todo>> fetchList() => db.getTodoList();
}
