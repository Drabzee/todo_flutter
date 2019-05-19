import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './todo_list.dart';
import '../model/todo_model.dart';

class TodoEdit extends StatefulWidget {
  final String _todoAppTitle;
  TodoEdit(this._todoAppTitle);

  @override
  State<StatefulWidget> createState() {
    return TodoEditState();
  }
}

class TodoEditState extends State<TodoEdit> {

  int todoPriority = 0;
  Todo tempTodo = Todo(0, '', '', 0, '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildTitleField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
      validator: (String value) {
        if(value.length == 0) return 'Title is required';
      },
      onSaved: (String value) {
        tempTodo.title = value;
      },
    );
  }

  Widget buildDescField() {
    return TextFormField(
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
      validator: (String value) {
        if(value.length == 0) return 'Description is required';
      },
      onSaved: (String value) {
        tempTodo.desc = value;
      },
    );
  }

  Widget buildPriorityField() {
    return Row(
      children: <Widget>[
        Text('Priority :', style: TextStyle(fontSize: 18.0),),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButtonFormField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            value: todoPriority,
            items: [
              DropdownMenuItem(value: 0, child: Text('High')),
              DropdownMenuItem(value: 1, child: Text('Medium')),
              DropdownMenuItem(value: 2, child: Text('Low'))
            ],
            onChanged: (value) {
              print(value); setState(() {
                todoPriority = value;
              });
            },
            onSaved: (int value) {
                tempTodo.priority = value;
            },
          )
        )
      ]
    );
  }

  void _saveForm() {
    if(!_formKey.currentState.validate())
      return;

    _formKey.currentState.save();
    tempTodo.id = 100 + todoList.length;
    tempTodo.date = DateFormat('dd MMM, y').format(DateTime.now());
    todoList.add(tempTodo);
    Navigator.of(context).pop();
  }

  Widget buildTodoForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            buildTitleField(),
            SizedBox(height: 20.0),
            buildDescField(),
            SizedBox(height: 20.0),
            buildPriorityField(),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: _saveForm,
              child: Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
              color: Colors.pink,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            ),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._todoAppTitle),
        backgroundColor: Colors.pink,
      ),
      body: buildTodoForm()
    );
  }
}