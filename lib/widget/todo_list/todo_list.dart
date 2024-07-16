import 'package:flutter/material.dart';
import 'package:todo_for_gtd/model/todo.dart';
import 'package:todo_for_gtd/widget/todo_list/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({
    super.key,
    required this.todos,
    required this.onRemoveTodo,
  });

  final List<Todo> todos;
  final void Function(Todo todo) onRemoveTodo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(todos[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
        ),
        onDismissed: (direction) {
          onRemoveTodo(todos[index]);
        },
        child: TodoItem(todos[index], onRemoveTodo),
      ),
    );
  }
}
