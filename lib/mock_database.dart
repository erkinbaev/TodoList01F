
import 'package:todo_app_01f/todo.dart';

class MockDatabase {
  final List<Todo> _items = [
    Todo(id: 1, title: 'Купить продукты', isFinished: false, date: '2026-01-20 18:30:00'),
    Todo(id: 2, title: 'Прочитать книгу', isFinished: false, date: '2026-01-21 10:15:00'),
    Todo(id: 3, title: 'Пойти на тренировку', isFinished: false, date: '2026-01-21 12:00:00')
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