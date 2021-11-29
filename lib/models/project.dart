import 'package:doodle_app/models/todo.dart';

class Project {
  String name;
  bool done;
  List <int> data;
  List <String> userPermissions;
  //List <Todo> todos;

  Project({required this.name, required this.done, required this.data, required this.userPermissions});//, required this.todos});

}