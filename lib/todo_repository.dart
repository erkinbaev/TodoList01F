
import 'package:todo_app_01f/mock_database.dart';
import 'package:todo_app_01f/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchList();
  Future<Todo> addTodo({required String title, required String date});
}

class TodoRepositoryImpl implements TodoRepository {
  //обертка над дазой данных
  final MockDatabase db;

  TodoRepositoryImpl(this.db);

  @override
  Future<Todo> addTodo({required String title, required String date}) => db.add(title, date);

  @override
  Future<List<Todo>> fetchList() => db.getList();
}
