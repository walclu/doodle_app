import 'package:doodle_app/models/dailytaskfirestore.dart';
import 'package:doodle_app/screens/projectPage/project_page.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/models/project.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class DailyProgressCircle extends StatelessWidget {
  //const ProjectTile({Key? key}) : super(key: key);

  final int index;

  DailyProgressCircle({required this.index});

  String _getProjectName(String name){
    int indexUnderscore = name.indexOf('_');
    return name.substring(0,indexUnderscore);
  }


  @override
  Widget build(BuildContext context) {
    final dailyTaskFirestore = Provider.of<List<DailyTaskFirestore>?>(context) ?? [];
    final dailyTask = dailyTaskFirestore[index];
    double todosProgress = 0;
    int numTodos = dailyTask.dailies.length;
    int todosFinished = 0;
    for(var todo in dailyTask.dailies){
      if(todo.done){
        todosFinished++;
      }
    }
    numTodos == 0? todosProgress = 0 : todosProgress = todosFinished/numTodos;
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectPage(index: index)));
        },
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.grey
          ),
          width: 195,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,),
              CircularPercentIndicator(
                backgroundColor: Colors.white,
                animation: true,
                animationDuration: 1800,
                lineWidth: 6,
                percent: todosProgress,
                progressColor: Colors.redAccent, radius: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
