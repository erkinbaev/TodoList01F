

import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/home/home_state.dart';
import 'package:todo_app_01f/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel {
  final TodoRepository repo;

  HomeViewModel({required this.repo});

  Future<List<Todo>> loadList() => repo.fetchList();

  Future<int> addTodo({required String title, required String date}) {
    return repo.addTodo(title: title, date: date);
  } 
}

class HomeCubit extends Cubit<HomeState> {
  final HomeViewModel vm;

  HomeCubit({required this.vm}) : super(HomeState.initial());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      //сначала ждем список потом выполняй следующее
      final items = await vm.loadList();
      //после получения данных только тогда фильтруем
      final filteredItems = _filterByDate(items);
      //после получения данных меняем state на то что данные имеются и отдаем список
      emit(state.copyWith(isLoading: false, items: filteredItems));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  } 

  List<Todo> _filterByDate(List<Todo> items) {
    return [...items]..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> addTest() async {
    final String title = "";
    final String date = DateTime.now().toString();

    try {
      if(title.isEmpty) {
        throw Exception("Empty field");
      } 

      await vm.addTodo(title: "Test", date: DateTime.now().toString());
      await init();

    } catch (e) {
      emit(state.copyWith(isLoading: false, error: null));
      emit(state.copyWith(isLoading: false, error: e.toString()));
      print(e);
    }
  }



}