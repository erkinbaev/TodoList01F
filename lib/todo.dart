class Todo {
  final int id;
  final String title;
  final bool isFinished;
  final String date;

  const Todo({required this.id, required this.title, required this.isFinished, required this.date});

  Todo copyWith( {
    int? id,
    String? title,
    bool? isFinished,
    String? date,
  }) {
    return Todo(id: id ?? this.id, title: title ?? this.title, isFinished: isFinished ?? this.isFinished, date: date ?? this.date);
  }
}