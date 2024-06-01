import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/utilities/db.dart';

class DatabaseHelper {
  
  final String tableTodo = 'todo';
  final String columnId = 'id';
  final String columnTitle = 'todoText';
  final String columnDone = 'isDone';

  

  

  Future<void> createTable(Database database) async{
    await database.execute(
      '''create table if not exists $tableTodo ( 
          $columnId varchar(255) primary key, 
          $columnTitle text not null,
          $columnDone integer not null
          );'''
    );
  }





  Future<ToDo> insert(ToDo todo) async {
    final database = await TodoProvider().database;
    todo.id = (await database.insert(tableTodo, todo.toMap())).toString();
    return todo;
  }

  Future<ToDo?> getTodo(int id) async {
    final database = await TodoProvider().database;
    List<Map> maps = await database.query(tableTodo,
        columns: [columnId, columnDone, columnTitle],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return ToDo.fromMap(maps.first as Map<String, Object?>);
    }
    return null;
  }

  Future<List<ToDo>> fetchAll() async{
    final database = await TodoProvider().database;
    final todos = await database.rawQuery(
      '''SELECT * FROM $tableTodo;''');
    return todos.map((todo) => ToDo.fromSqfliteDatabase(todo)).toList();
  }


  Future<int> delete(String id) async {
    final database = await TodoProvider().database;
    return await database
        .delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(ToDo todo) async {
    final database = await TodoProvider().database;
    return await database.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }
}
