import 'package:todo_app_01f/add/add_state.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddViewModel {
  final TodoRepository repo;

  AddViewModel({required this.repo});

  Future<int> addTodo({required String title, required String date}) {
    return repo.addTodo(title: title, date: date);
  } 
}

class AddCubit extends Cubit<AddState> {
  final AddViewModel vm;

  AddCubit({required this.vm}) : super(AddState.initial());

  Future<void> addTodo(String title) async {
    final String date = DateTime.now().toString();

    try {
      if(title.isEmpty) {
        throw Exception("Empty field");
      } 

      await vm.addTodo(title: title, date: date);

    } catch (e) {
     emit(state.copyWith(isEmptyField: true));
    }
  }

}