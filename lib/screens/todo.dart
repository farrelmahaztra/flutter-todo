import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/widgets/form.dart';
import 'package:todo/widgets/details.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  TodoScreenState createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];

  void _handleCreateTodo(Todo todo) {
    setState(() {
      todos.add(todo);
    });
  }

  void _handleDeleteTodo() {
    setState(
        () => {todos = todos.where((todo) => todo.selected != true).toList()});
  }

  void _handleSelectTodo(bool? value, int index) {
    setState(() {
      if (value == true) {
        todos[index].selected = true;
      } else {
        todos[index].selected = false;
      }
    });
  }

  final ScrollController _scrollController = ScrollController();

  Widget _body() {
    if (todos.isEmpty) {
      return const Padding(
          padding: EdgeInsets.all(18), child: Text('No todos found.'));
    }
    return ListView.separated(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: Checkbox(
                value: todos[index].selected,
                onChanged: (bool? value) {
                  _handleSelectTodo(value, index);
                },
              ),
              title: Text(
                todos[index].title,
              ),
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return TodoDetails(todo: todos[index]);
                  }));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              thickness: 1,
            ),
        itemCount: todos.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: <Widget>[
          if (todos.where((todo) => todo.selected == true).toList().isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _handleDeleteTodo();
              },
            )
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (builder) {
              return TodoForm(
                  todos: todos, handleCreateTodo: _handleCreateTodo);
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
