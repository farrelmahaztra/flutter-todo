import 'package:flutter/material.dart';
import 'package:todo/widgets/screen.dart';

class Todo {
  String title;
  String description;
  bool? selected = false;

  Todo(this.title, this.description);
}

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Screen(), debugShowCheckedModeBanner: false);
  }
}
