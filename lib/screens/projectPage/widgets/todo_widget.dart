import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/projectPage/widgets/todo_overview_widget.dart';
import 'package:doodle_app/screens/projectPage/settings_form.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatefulWidget {
  int todoIndexInProjectList;
  int projectIndex;
  TodoWidget({required this.projectIndex, required this.todoIndexInProjectList});

  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>?>(context) ?? [];
    final user = Provider.of<UserMod?>(context);
    return Container(
      child: Row(
        children: [
          projects[widget.projectIndex].todos[widget.todoIndexInProjectList].state?
              GestureDetector(
                onTap: (){
                  bool newState = !projects[widget.projectIndex].todos[widget.todoIndexInProjectList].state;
                  projects[widget.projectIndex].todos[widget.todoIndexInProjectList].state = newState;
                  DataBaseService(uid: user!.uid).updateProject(
                      projects[widget.projectIndex].name,
                      projects[widget.projectIndex].done,
                      projects[widget.projectIndex].todos,
                    projects[widget.projectIndex].userPermissions,
                  );
                },
                  child: Icon(Icons.check_circle, color: Colors.lightGreenAccent,)
              ) :
          GestureDetector(
              onTap: (){
                bool newState = !projects[widget.projectIndex].todos[widget.todoIndexInProjectList].state;
                projects[widget.projectIndex].todos[widget.todoIndexInProjectList].state = newState;
                DataBaseService(uid: user!.uid).updateProject(
                  projects[widget.projectIndex].name,
                  projects[widget.projectIndex].done,
                  projects[widget.projectIndex].todos,
                  projects[widget.projectIndex].userPermissions,
                );
              },
              child: Icon(Icons.check_circle, color: Colors.grey,)
          ),
          SizedBox(width: 30,),
          Text(
              projects[widget.projectIndex].todos[widget.todoIndexInProjectList].name,
          )
        ],
      ),
    );
  }
}
