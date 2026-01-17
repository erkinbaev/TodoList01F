
import 'package:todo_app_01f/todo.dart';

class MockDatabase {
  final List<Todo> _items = [
    // Todo(id: 1, title: 'Купить продукты', isFinished: false, date: DateTime.now().toString()),
    // Todo(id: 2, title: 'Прочитать книгу', isFinished: false, date: DateTime.now().toString()),
    // Todo(id: 3, title: 'Пойти на тренировку', isFinished: false, date: DateTime.now().toString())
  ];

  int _nextId = 4;

  Future<Todo> add(String title, String date) async {
    final todo = Todo(id: _nextId++, title: title, isFinished: false, date: date);
    return todo;
  }

  Future<List<Todo>> getList() async {
    return List.unmodifiable(_items);
  }

  //delete

  //update
}