import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  const ToDoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white
      ),
      child: ListTile(
        onTap: () {
          print("It's working");
        },
        leading: Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank, color: blue,),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: black,
              decoration: todo.isDone? TextDecoration.lineThrough : null,
              ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(5),
          height: 35,
          width: 35,
          decoration:
              BoxDecoration(color: red, borderRadius: BorderRadius.circular(7)),
          child: IconButton(
            onPressed: () {
              print("it's also working");
            },
            icon: const Icon(Icons.delete),
            iconSize: 18,
            color: white,
          ),
        ),
      ),
    );
  }
}