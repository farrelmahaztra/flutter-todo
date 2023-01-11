import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/main.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void handleCreate() {
    Todo todo = Todo(titleController.text, descriptionController.text);
    Provider.of<TodoAppState>(context, listen: false).handleCreateTodo(todo);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double viewportHeight = MediaQuery.of(context).size.height;

    return Container(
        height: viewportHeight * 0.3,
        alignment: Alignment.center,
        child: Form(
            key: formKey,
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        labelText: "Title", hintText: "Do my chores"),
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        labelText: "Description",
                        hintText:
                            "Wash the dishes, feed my cat, take out the trash"),
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 16),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          handleCreate();
                          Navigator.pop(context);
                        },
                        child: const Text('Create'),
                      )),
                ]))));
  }
}
