import 'package:flutter/material.dart';

class toDoModel {
  String? date;
  String? task;
  bool isCompleted = false;
  toDoModel(this.date, String task) {
    this.date = date;
    this.task = task;
  }
}
