import 'package:flutter/material.dart';
import 'package:todo_for_gtd/model/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key, required this.onAddTodo});

  final void Function(Todo todo) onAddTodo;

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitTodoData() {
    if (_titleController.text.trim() == null ||
        _descriptionController.text.trim() == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("不正入力"),
                content: const Text("入力が間違っています"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Okay'),
                  )
                ],
              ));
    }
    widget.onAddTodo(
      Todo(
          title: _titleController.text,
          description: _descriptionController.text,
          isDone: false,
          dueDateTime: _selectedDate!,
          generateDateTime: DateTime.now(),
          isTodayTask: false,
          isImportant: false),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 100,
            decoration: const InputDecoration(
              label: Text("タスク名"),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 100,
            decoration: const InputDecoration(
              label: Text("詳細"),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : formatter.format(_selectedDate!),
                ),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitTodoData,
                child: const Text('Todoを作成'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
