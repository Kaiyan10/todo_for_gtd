import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Priority {
  urgent('緊急'),
  high("高"),
  middle("中"),
  low("低");

  const Priority(this.displayName);

  final String displayName;
}

const uuid = Uuid();

class Todo {
  Todo({
    required this.title,
    required this.description,
    required this.isDone,
    required this.generateDateTime,
    required this.dueDateTime,
    this.priority = Priority.middle,
    this.category,
    required this.isTodayTask,
    required this.isImportant,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final String description;
  bool isDone;
  final DateTime dueDateTime;
  final DateTime generateDateTime;
  Priority priority;
  String? category;
  final bool isTodayTask;
  final bool isImportant;
}
