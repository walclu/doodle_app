import 'package:doodle_app/screens/projectPage/project_page.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/models/project.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProjectTile extends StatelessWidget {
  //const ProjectTile({Key? key}) : super(key: key);

  final Project project;
  final int index; 
  ProjectTile({required this.project, required this.index});

  String _getProjectName(String name){
    int indexUnderscore = name.indexOf('_');
    return name.substring(0,indexUnderscore);
  }


  @override
  Widget build(BuildContext context) {
    double todosProgress = 0;
    int numTodos = project.todos.length;
    int todosFinished = 0;
    for(var todo in project.todos){
      if(todo.state){
        todosFinished++;
      }
    }
    numTodos == 0? todosProgress = 0 : todosProgress = todosFinished/numTodos;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectPage(index: index))); 
      },
      child: Container(
        width: 200,
        child: Card(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 20, bottom: 1, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                project.todos.length == 1 ?
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("${project.todos.length} task",
                  style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500]
                  ),
                  ),
                ) :
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("${project.todos.length} tasks",
                    style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500]
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(_getProjectName(project.name),
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                LinearPercentIndicator(
                  backgroundColor: Colors.grey[200],
                  width: 164,
                  animation: true,
                  animationDuration: 1800,
                  lineHeight: 6,
                  percent: todosProgress,
                  linearStrokeCap: LinearStrokeCap.roundAll,
                  progressColor: Color.fromRGBO(253,91,255,1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
