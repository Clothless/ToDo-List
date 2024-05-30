class ToDo {
  String? id;
  String?todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList(){
    return [
      ToDo(id: '1', todoText: "Something to do"),
      ToDo(id: '2', todoText: "Build the damn app"),
      ToDo(id: '3', todoText: "Read books", isDone: true),
    ];
  }


}