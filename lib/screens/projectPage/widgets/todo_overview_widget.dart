import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/projectPage/widgets/todo_form.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TodoOverView extends StatefulWidget {
  final int index;


  TodoOverView({required this.index});

  @override
  _TodoOverViewState createState() => _TodoOverViewState();
}

class _TodoOverViewState extends State<TodoOverView> {

  // Future<void> _showTodoPanel(context, Project project, int index) async {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
  //           child: TodoForm(project: project, index: index,),
  //         );
  //       });
  // }
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>?>(context) ?? [];
    final user = Provider.of<UserMod?>(context);
    final project = projects[widget.index];
    final todos = project.todos;
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.72,
      child: ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) async {
          setState(() {
            final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
            final todo = todos.removeAt(oldIndex);
            todos.insert(index, todo);
          });
          await DataBaseService(uid: user!.uid).updateProject(
              project.name,
              project.done,
              todos,
              project.userPermissions);
        },
        itemCount: todos.length,
        itemBuilder: (context, it) {
          final todo = todos[it];
          return ListTile(
            key: ValueKey(todo),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: todo.state? Text(todo.name,
              style: GoogleFonts.openSans(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey,
              ),
            ) : Text(todo.name,
              style: GoogleFonts.openSans(
                color: Colors.black,
              ),
            ),
            leading: IconButton(
              onPressed: () async {
                todos[it].state = !todos[it].state;
                await DataBaseService(uid: user!.uid).updateProject(
                    project.name,
                    project.done,
                    todos,
                    project.userPermissions);
                setState(() {

                });
              },
              icon: todo.state? Icon(Icons.check_box_outlined,
                color: Colors.black,
              ): Icon(Icons.check_box_outline_blank_rounded,
                color: Colors.black,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TodoForm(project: project, index: it)));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () async {
                    todos.removeAt(it);
                    await DataBaseService(uid: user!.uid).updateProject(
                        project.name,
                        project.done,
                        todos,
                        project.userPermissions);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
