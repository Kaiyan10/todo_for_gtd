import 'package:todo_for_gtd/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TodoItem extends StatefulWidget {
  const TodoItem(this.todo, this.onRemoveTodo, {super.key});

  final void Function(Todo todo) onRemoveTodo;
  final Todo todo;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ja_JP');
    var formatter = DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");

    return Column(
      children: [
        CheckboxListTile(
          value: widget.todo.isDone,
          title: Text(
            widget.todo.title,
          ),
          onChanged: (bool? value) {
            setState(() {
              widget.todo.isDone = value!;
              widget.onRemoveTodo(widget.todo);
            });
          },
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      widget.todo.priority.displayName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  )),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formatter.format(widget.todo.dueDateTime),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.todo.description.toString(),
                style: const TextStyle(
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 0,
        )
      ],
    );
  }
}
