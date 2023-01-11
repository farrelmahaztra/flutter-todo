import 'package:flutter/material.dart';
import 'package:todo/widgets/screen.dart';

class Todo {
  String title;
  String description;
  bool? selected = false;

  Todo(this.title, this.description);
}

void main() {
  runApp(const StateContainer(
    child: TodoApp(),
  ));
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
        themeMode: StateContainer.of(context).darkModeEnabled
            ? ThemeMode.dark
            : ThemeMode.light,
        debugShowCheckedModeBanner: false);
  }
}

class StateContainer extends StatefulWidget {
  final Widget child;

  const StateContainer({
    super.key,
    required this.child,
  });

  static StateContainerState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>())!
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  List<Todo> todos = [];
  bool darkModeEnabled = false;

  void handleCreateTodo(Todo todo) {
    setState(() => {todos.add(todo)});
  }

  void handleDeleteTodo() {
    setState(
        () => {todos = todos.where((todo) => todo.selected != true).toList()});
  }

  void handleSelectTodo(bool? value, int index) {
    setState(() => {
          if (value == true)
            {todos[index].selected = true}
          else
            {todos[index].selected = false}
        });
  }

  void toggleDarkMode() {
    setState(() => {darkModeEnabled = !darkModeEnabled});
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;

  const _InheritedStateContainer({
    required this.data,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
