import 'package:todo_app_01f/database/app_database.dart';

class AddState {
  final bool isEmptyField;
  final String? error;

  const AddState({required this.isEmptyField, required this.error});

//состояние по умалспниию
  factory AddState.initial() => const AddState(isEmptyField: false, error: null);

  AddState copyWith({
    bool? isEmptyField,
    String? error,
  }) {
    return AddState(isEmptyField: isEmptyField?? this.isEmptyField, error: error ?? error);
  }
}