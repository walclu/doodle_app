import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
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
            title: Text(todo.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Change todo name"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await DataBaseService(uid: user!.uid).updateProject(
                                    project.name,
                                    project.done,
                                    todos,
                                    project.userPermissions);
                                Navigator.of(context).pop();
                              },

                              child: Text("Change"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                          content: TextFormField(
                            initialValue: todo.name,
                            onFieldSubmitted: (_) =>
                                Navigator.of(context).pop(),
                            onChanged: (name) async {
                              setState(() {
                                todos[it].name = name;
                              });
                            },
                          ),
                        );
                      },
                    );
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
