import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:todo/widgets/screen.dart';

class Todo {
  String title;
  String description;
  bool? selected = false;

  Todo(this.title, this.description);
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoAppState(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const Screen(),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: Provider.of<TodoAppState>(context).darkModeEnabled
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false);
  }
}

class TodoAppState extends ChangeNotifier {
  List<Todo> todos = [];
  bool darkModeEnabled = false;

  void handleCreateTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  void handleDeleteTodo() {
    todos = todos.where((todo) => todo.selected != true).toList();
    notifyListeners();
  }

  void handleSelectTodo(bool? value, int index) {
    if (value == true) {
      todos[index].selected = true;
    } else {
      todos[index].selected = false;
    }
    notifyListeners();
  }

  void toggleDarkMode() {
    darkModeEnabled = !darkModeEnabled;
    notifyListeners();
  }
}
