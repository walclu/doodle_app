import 'dart:math';

import 'package:doodle_app/shared/constants.dart';
import 'package:doodle_app/widgets/projectPage/project_page.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/models/project.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ProjectCard extends StatelessWidget {
  //const ProjectCard({Key? key}) : super(key: key);

  final int index; 
  ProjectCard({required this.index});

  String _getProjectName(String name){
    int indexUnderscore = name.indexOf('_');
    return name.substring(0,indexUnderscore);
  }
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>?>(context) ?? [];
    final Project project = projects[index];
    double todosProgress = 0;
    int numTodos = project.todos.length;
    int todosFinished = 0;
    for(var todo in project.todos){
      if(todo.state){
        todosFinished++;
      }
    }
    numTodos == 0? todosProgress = 0 : todosProgress = todosFinished/numTodos;
    var rnd = Random();
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectPage(index: index)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors:
                colorPalette[rnd.nextInt(colorPalette.length)]
            ),
          ),
          width: 195,
          child: Container(
            padding: const EdgeInsets.only(left: 10, top: 20, bottom: 1, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                project.todos.length == 1 ?
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("${project.todos.length} task",
                  style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                ) :
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("${project.todos.length} tasks",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(_getProjectName(project.name),
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16,),
                LinearPercentIndicator(
                  backgroundColor: Colors.white,
                  width: 167,
                  animation: true,
                  animationDuration: 1800,
                  lineHeight: 6,
                  percent: todosProgress,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Color(project.color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
