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

  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>?>(context) ?? [];
    final user = Provider.of<UserMod?>(context);
    final project = projects[widget.index];
    final todos = project.todos;
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
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
                project.userPermissions,
                project.color
            );
          },
          itemCount: todos.length,
          itemBuilder: (context, it) {
            return GestureDetector(
              key: ValueKey(todos[it]),
              onDoubleTap: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TodoForm(project: project, index: it)));
              },
              onTap: () async {
                todos[it].state = !todos[it].state;
                await DataBaseService(uid: user!.uid).updateProject(
                    project.name,
                    project.done,
                    todos,
                    project.userPermissions,
                    project.color
                );
                setState(() {

                });
              },

              child: Dismissible(
                key: ValueKey(todos[it]),
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.redAccent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Delete",
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) async {
                  Todo safe = projects[widget.index].todos[it];
                  todos.removeAt(it);
                  await DataBaseService(uid: user!.uid).updateProject(
                      project.name,
                      project.done,
                      todos,
                      project.userPermissions,
                      project.color
                  );
                  setState(() {

                  });
                  final snackBar = SnackBar(
                    content: const Text('Task deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () async {
                        todos.insert(it, safe);
                        await DataBaseService(uid: user.uid).updateProject(
                            project.name,
                            project.done,
                            todos,
                            project.userPermissions,
                            project.color
                        );
                        setState(() {

                        });
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);


                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.circle_outlined,
                        color: Color(project.color),
                      ),
                      SizedBox(width: 20,),
                      Text(project.todos[it].name,
                        style: GoogleFonts.openSans(
                          decoration: project.todos[it].state? TextDecoration.lineThrough : null,
                          fontSize: 13,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );



    /*Container(
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
              project.userPermissions,
              project.color
          );
        },
        itemCount: todos.length,
        itemBuilder: (context, it) {
          final todo = todos[it];
          return Dismissible(
            key: ValueKey(todo),
            onDismissed: (direction) async {
                todos.removeAt(it);
                await DataBaseService(uid: user!.uid).updateProject(
                    project.name,
                    project.done,
                    todos,
                    project.userPermissions,
                    project.color
                );
            },
            child: Container(

              child: ListTile(
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
                        project.userPermissions,
                        project.color
                    );
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );*/
  }
}
