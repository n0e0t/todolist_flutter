// lib/models/task.dart
import 'package:flutter/material.dart';

class Task {
  final String id;
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  int priority;
  String category;
  bool status;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    required this.priority,
    required this.category,
    required this.status
  });
}
