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
  final ScrollController _scrollController = ScrollController();

  Widget _body() {
    if (StateContainer.of(context).todos.isEmpty) {
      return const Padding(
          padding: EdgeInsets.all(18), child: Text('No todos found.'));
    }
    return ListView.separated(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: Checkbox(
                value: StateContainer.of(context).todos[index].selected,
                onChanged: (bool? value) {
                  StateContainer.of(context).handleSelectTodo(value, index);
                },
              ),
              title: Text(
                StateContainer.of(context).todos[index].title,
              ),
              onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return TodoDetails(
                        todo: StateContainer.of(context).todos[index]);
                  }));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
              thickness: 1,
            ),
        itemCount: StateContainer.of(context).todos.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: <Widget>[
          if (StateContainer.of(context)
              .todos
              .where((todo) => todo.selected == true)
              .toList()
              .isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                StateContainer.of(context).handleDeleteTodo();
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
                  todos: StateContainer.of(context).todos,
                  handleCreateTodo:
                      StateContainer.of(context).handleCreateTodo);
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
