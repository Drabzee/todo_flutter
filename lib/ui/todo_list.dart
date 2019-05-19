import 'package:flutter/material.dart';
import '../model/todo_model.dart';
import 'dart:math';
import 'package:vibration/vibration.dart';
import './todo_edit.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {

  alertDialog(BuildContext context, int index) {
    var alertBox = AlertDialog(
      title: Text('Are you sure to delete?'),
      content: Text('Delete opertion cannot be undone'),
      actions: <Widget>[
        FlatButton(child: Text('Yes'), onPressed: () {
          setState(() {
            todoList.removeAt(index);
          Navigator.of(context).pop();
          });
        }),
        FlatButton(child: Text('No'), onPressed: () {
          setState(() {
            Todo tempTodo = todoList[index];
            tempTodo.id = todoList.length + 100;
            todoList.removeAt(index);
            todoList.add(tempTodo);
          Navigator.of(context).pop();
          });
        })
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertBox;
      });
  }

  Widget buildTodoList(BuildContext context) {

    var rng = Random();

    return todoList.length == 0
      ? Center(child: Text('No Todos'))
      : ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(rng.nextDouble().toString()),
              onDismissed: (DismissDirection direction) async {
                if(await Vibration.hasVibrator()) {
                  Vibration.vibrate(duration: 50);
                }
                alertDialog(context, index);
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: todoList[index].getPriorityColor(),
                  child: Icon(Icons.keyboard_arrow_right, color: Colors.white),
                ),
                title: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    todoList[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                subtitle: Text(todoList[index].desc),
                trailing: Text(todoList[index].date),
                onTap: () {},
              )
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    
    todoList.sort((item1, item2) => item1.priority.compareTo(item2.priority));

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TodoEdit('Add Todo')));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,

      ),
      body: buildTodoList(context)
    );
  }
}
