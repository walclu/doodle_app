import 'package:doodle_app/models/todo.dart';

class Project {
  String name;
  bool done;
  //List <int> data;
  List <String> userPermissions;
  List <Todo> todos;
  int color;

  Project({required this.name, required this.done, required this.todos, required this.userPermissions, required this.color});//, required this.todos});

}