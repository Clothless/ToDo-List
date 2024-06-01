
import 'package:todo_list/utilities/db.dart';

class ToDo {
  String? id;
  String? todoText;
  int isDone = 0;


  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = 0,
  });

  factory ToDo.fromSqfliteDatabase(Map<String, dynamic> map) => ToDo(
    id: map['id'] ?? '',
    todoText: map['todoText'] ?? '',
    isDone: map['isDone'] ?? 0,
  );

  Map<String, Object?> toMap() {
    var map = <String, Object?>{};
    map[columnTitle] = todoText;
    map[columnDone] = isDone;
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
  // ToDo();

  ToDo.fromMap(Map<String, Object?> map) {
    id = map[columnId] as String?;
    todoText = map[columnTitle] as String?;
    isDone = map[columnDone] as int;
  }

  static List<ToDo> todoList() {
    return [
      ToDo(id: '1', todoText: "Something to do"),
      ToDo(id: '2', todoText: "Build the damn app"),
      ToDo(id: '3', todoText: "Read books", isDone: 1),
    ];
  }
}
