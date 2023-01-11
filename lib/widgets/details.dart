import 'package:flutter/material.dart';
import 'package:todo/main.dart';

class TodoDetails extends StatelessWidget {
  const TodoDetails({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    double viewportHeight = MediaQuery.of(context).size.height;

    return SizedBox(
        height: viewportHeight * 0.1,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(todo.description, textAlign: TextAlign.left)
              ],
            )));
  }
}
