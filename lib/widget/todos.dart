import 'package:flutter/material.dart';
import 'package:todo_for_gtd/model/todo.dart';
import 'package:todo_for_gtd/screen/setting_screen.dart';
import 'package:todo_for_gtd/widget/todo_list/todo_list.dart';
import 'package:todo_for_gtd/widget/new_todo.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  final List<Todo> _registeredTodos = [
    Todo(
        title: "歯医者の予約をする",
        description: "電話番号は、xxx-xxxx-xxxx",
        isDone: false,
        dueDateTime: DateTime(2024, 8, 31),
        priority: Priority.high,
        isTodayTask: false,
        isImportant: false),
    Todo(
        title: "トイレ掃除する",
        description: "",
        isDone: false,
        dueDateTime: DateTime(2024, 8, 31),
        priority: Priority.middle,
        isTodayTask: false,
        isImportant: false)
  ];
  final List<Todo> _doneTodos = [];

  void _openAddTodoOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewTodo(
        onAddTodo: _addTodo,
      ),
      isScrollControlled: true,
    );
  }

  void _addTodo(Todo todo) {
    setState(() {
      _registeredTodos.add(todo);
    });
  }

  void _removeTodo(Todo todo) {
    final todoIndex = _registeredTodos.indexOf(todo);
    setState(() {
      _registeredTodos.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Todoを削除しました。"),
      action: SnackBarAction(
        label: "もとに戻す",
        onPressed: () {
          setState(() {
            _registeredTodos.insert(todoIndex, todo);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("Todoがありません"),
    );

    if (_registeredTodos.isNotEmpty) {
      mainContent = TodoList(
        todos: _registeredTodos,
        onRemoveTodo: _removeTodo,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todoアプリ"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingScreen()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: mainContent),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodoOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
