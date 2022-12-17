import 'package:assignment_three/db_model.dart';
import 'package:assignment_three/todo_list.dart';
import 'package:assignment_three/todo_model.dart';
import 'package:assignment_three/user_input.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var db = DatabaseConnect();

  void addItem(Todo todo) async {
    await db.insertTodo(todo);
    setState(() {});
  }

  void deleteItem(Todo todo) async {
    await db.deleteTodo(todo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple todo app'),
      ),
      backgroundColor: const Color(0xFFF5EBFF),
      body: Column(
        children: [
          Todolist(insertFunction: addItem, deleteFunction: deleteItem),
          UserInput(insertFunction: addItem),
        ],
      ),
    );
  }
}