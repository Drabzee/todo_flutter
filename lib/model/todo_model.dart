import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Todo {
  int _id;
  String _title;
  String _desc;
  int _priority;
  String _date;

  int get id => this._id;
  String get title => this._title;
  String get desc => this._desc;
  int get priority => this._priority;
  String get date => this._date;

  set id(id) { this._id = id; }
  set title(title) {this. _title = title; }
  set desc(desc) { this._desc = desc; }
  set priority(priority) { this._priority = priority; }
  set date(date) { this._date = date; }

  Todo(this._id, this._title, this._desc, this._priority, this._date);

  Color getPriorityColor() {
    Color color;
    switch(this._priority) {
      case 0 : color = Colors.red;
               break;
      case 1 : color = Colors.yellow;
               break;
      case 2 : color = Colors.green;
               break;
      default : color = Colors.green;
    }
    return color;
  }
}

List<Todo> todoList = [
  Todo(100, 'Buy Flowers', 'Flowers to make a hand made bookey', 2, DateFormat('dd MMM, y').format(DateTime.now())),
  Todo(101, 'Buy Flowers', 'Flowers to make a hand made bookey', 1, DateFormat('dd MMM, y').format(DateTime.now())),
  Todo(102, 'Buy Flowers', 'Flowers to make a hand made bookey', 0, DateFormat('dd MMM, y').format(DateTime.now())),
  Todo(103, 'Buy Flowers', 'Flowers to make a hand made bookey', 1, DateFormat('dd MMM, y').format(DateTime.now())),
  Todo(104, 'Buy Flowers', 'Flowers to make a hand made bookey', 2, DateFormat('dd MMM, y').format(DateTime.now())),
  Todo(105, 'Buy Flowers', 'Flowers to make a hand made bookey', 1, DateFormat('dd MMM, y').format(DateTime.now())),
  Todo(106, 'Buy Flowers', 'Flowers to make a hand made bookey', 0, DateFormat('dd MMM, y').format(DateTime.now())),
];