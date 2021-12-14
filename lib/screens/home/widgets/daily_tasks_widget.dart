import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';

class DailyTasksWidget extends StatefulWidget {
  const DailyTasksWidget({Key? key}) : super(key: key);

  @override
  _DailyTasksWidgetState createState() => _DailyTasksWidgetState();
}

class _DailyTasksWidgetState extends State<DailyTasksWidget> {
  bool isToday(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    return diff == 0 && now.day == date.day;
  }

  List<Map<String,dynamic>> _getDailyTasks(List<Project> projects) {
    List<Map<String,dynamic>> dailyTasks = [];
    late DateTime temp;
    for (int i = 0; i < projects.length; i++) {
      for (int j = 0; j < projects[i].todos.length; j++) {
        temp = DateTime.parse(projects[i].todos[j].whenToStart);
        if (isToday(temp)) {
          dailyTasks.add({
            'projNum': i,
            'todoNum': j,
            'todo': projects[i].todos[j],
          });

        }
      }
    }
    return dailyTasks;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context);
    final projects = Provider.of<List<Project>?>(context) ?? [];
    List<Map<String,dynamic>> dailyTasks = _getDailyTasks(projects);
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: dailyTasks.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ValueKey(dailyTasks[index]['todo']),
              onDismissed: (direction) async {
                int projNum = dailyTasks[index]['projNum'];
                int todoNum = dailyTasks[index]['todoNum'];
                print(todoNum);
                List<Todo> temp = projects[projNum].todos;
                temp.removeAt(todoNum);
                dailyTasks.removeAt(index);
                await DataBaseService(uid: user.uid).updateProject(
                    projects[projNum].name,
                    projects[projNum].done,
                    temp,
                    projects[projNum].userPermissions);
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
                    Icon(Icons.circle_outlined),
                    SizedBox(width: 20,),
                    Text(dailyTasks[index]['todo']!.name,
                      style: GoogleFonts.openSans(
                        fontSize: 13,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
