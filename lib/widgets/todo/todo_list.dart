import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/widgets/todo/todo_form.dart';
import 'package:doodle_app/widgets/todo/todo_widget_ui.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  final int index;


  TodoList({required this.index});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> with SingleTickerProviderStateMixin{



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
            TodoWidgetUi todoWidgetUi = TodoWidgetUi(todo: project.todos[it],);
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
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
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
                child: todoWidgetUi
              ),
            );
          },
        ),
      ),
    );
  }
}
