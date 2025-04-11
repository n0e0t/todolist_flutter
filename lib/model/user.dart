
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/task.dart';

class User {
  String username;
  String password;
  String? imagePath;
  ValueNotifier<List<Task>> taskList;

  User({
    required this.username,
    required this.password,
    this.imagePath = 'assets/icons/cat.png',
    ValueNotifier<List<Task>>? taskList,
  }) : taskList = taskList ?? ValueNotifier([]);
}
