import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'todos.dart'; 
part 'app_database.g.dart'; 

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  //CREATE
  Future<int> insertTodo(TodosCompanion todo) {
   return into(todos).insert(todo);
  }

  //READ
  Future<List<Todo>> getTodoList() {
    return select(todos).get();
  }

  //UPDATE
  Future<int> updateTodo(int id, TodosCompanion data) {
    return (update(todos)..where((t) => t.id.equals(id))).write(data);
  }

  //DELETE
  Future<int> deleteTodo(int id) {
    return (delete(todos)..where((t) => t.id.equals(id))).go();
  }

  
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}