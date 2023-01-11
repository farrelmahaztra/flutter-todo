import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';
import 'package:todo/widgets/form.dart';
import 'package:todo/widgets/details.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  TodoScreenState createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {
  final ScrollController _scrollController = ScrollController();

  Widget _body() {
    List<Todo> todos = Provider.of<TodoAppState>(context).todos;

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
                  Provider.of<TodoAppState>(context, listen: false)
                      .handleSelectTodo(value, index);
                },
              ),
              title: Text(
                Provider.of<TodoAppState>(context).todos[index].title,
              ),
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return TodoDetails(
                        todo: Provider.of<TodoAppState>(context).todos[index]);
                  }));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              thickness: 1,
            ),
        itemCount: Provider.of<TodoAppState>(context).todos.length);
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = Provider.of<TodoAppState>(context).todos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: <Widget>[
          if (Provider.of<TodoAppState>(context)
              .todos
              .where((todo) => todo.selected == true)
              .toList()
              .isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<TodoAppState>(context, listen: false)
                    .handleDeleteTodo();
              },
            )
        ],
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (builder) {
              return const TodoForm();
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
