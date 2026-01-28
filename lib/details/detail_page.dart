import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_01f/database/app_database.dart';
import 'package:todo_app_01f/main.dart';

class DetailPage extends StatefulWidget{
  final Todo todo;

  const DetailPage({super.key, required this.todo});

  @override
  State<DetailPage> createState() => _DetailPage();

}

class _DetailPage extends State<DetailPage> {
 late final TextEditingController _controller ;
 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = TextEditingController(text: widget.todo.title);
    
  }

  Future<void> _update() async {
    late final String newTitle;
    newTitle = _controller.text;

    await database.updateTodo(widget.todo.id, TodosCompanion(title: Value(newTitle)));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Детали"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Flex(direction: Axis.vertical,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Название",
              border: OutlineInputBorder(),
            ),
          ),
          TextButton(onPressed: _update, child: Text("Сохранить")),
          TextButton(onPressed: () => (), child: Text("Удалить"))
        ],
        ),
        ),
    );
  }

}