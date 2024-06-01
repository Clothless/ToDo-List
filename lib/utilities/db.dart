import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:todo_list/utilities/db_helper.dart';

const String tableTodo = 'todo';
const String columnId = 'id';
const String columnTitle = 'todoText';
const String columnDone = 'isDone';




class TodoProvider {
  
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<String> get fullPath async{
    const dbName = "todo.db";
    final path = await getApplicationDocumentsDirectory();
    return p.join(path.path, dbName);
  }

  _initDatabase() async {
    final path = await fullPath;
    final exists = await databaseExists(path);
    if(!exists){
      print('Creating a new database');
      try {
        await Directory(path).create(recursive: true);
      } catch (e) {
        print(e.toString());
      }
      print("created successefuly");
      ByteData data = await rootBundle.load(p.join("assets", "todo.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      print('Start writing');
      // await File(path).writeAsBytes(bytes, flush: true);
      print('Finish writing');
    }else{
      print("opening Database");
    }
    print(path);
    await deleteDatabase(path);
    var database = await openDatabase(
      (path),
      version: 1,
      onCreate: create,
      singleInstance: true,
      );
      return database;
  }

  Future<void> create(Database database, int version) async=>
    await DatabaseHelper().createTable(database);
  
  

  
}
