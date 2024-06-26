import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/utilities/db.dart';
import 'package:todo_list/utilities/db_helper.dart';
import 'package:todo_list/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final todoList = <ToDo>[];
List<ToDo> _foundToDo = [];
final _todoController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu_rounded,
              color: Colors.transparent,
            ),
            Icon(Icons.person)
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(color: bgColor),
            child: Column(
              children: [
                SearchBox(),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 50),
                        child: const Text(
                          "All Tasks",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: DatabaseHelper().fetchAll(),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.data == null) {
                            return Center(
                              child: Text("Nothing here"),
                            );
                          } else {
                            _foundToDo = snapshot.data!;
                            print(snapshot.data);
                            return Expanded(
                              child: ListView(
                                children: [
                                  for (ToDo item in _foundToDo)
                                    ToDoItem(
                                      todo: item,
                                      onToDoChanged: _handleChange,
                                      onDeleteItem: _deleteItem,
                                    )
                                ],
                              ),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 10, left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: white,
                      boxShadow: [
                        BoxShadow(
                          color: grey,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                          hintText: "Add new task...",
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(40, 40),
                      elevation: 10,
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleChange(ToDo todo) {
    if (todo.isDone == 1) {
      print("making it false");
      todo.isDone = 0;
      setState(() {
        DatabaseHelper().update(todo);
      });
    } else {
      todo.isDone = 1;
      print("making it true");
      setState(() {
        DatabaseHelper().update(todo);
      });
    }
  }

  void _deleteItem(String id) {
    setState(() {
      DatabaseHelper().delete(id);
    });
  }

  void _addToDoItem(String todo) async {
    setState(() {
      ToDo temp = ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: todo);
      DatabaseHelper().insert(temp);
    });
    _todoController.clear();
  }

  void _runFilter(String enteredText) {
    List<ToDo> results = [];
    if (enteredText.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((element) => element.todoText!
              .toLowerCase()
              .contains((enteredText.trim()).toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  Widget SearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: grey,
            ),
            prefixIconConstraints:
                const BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: grey)),
      ),
    );
  }
}
