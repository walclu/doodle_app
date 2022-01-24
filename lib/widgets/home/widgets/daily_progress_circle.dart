import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'daily_task_page.dart';

class DailyProgressCircle extends StatelessWidget {
  final int index;

  DailyProgressCircle({required this.index});

  @override
  Widget build(BuildContext context) {

    final dailyTaskFirestore = Provider.of<List<DailyTaskFirestore>?>(context) ?? [];

    String cardName = dailyTaskFirestore[index].permissions[0];
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
          //print(index);
          Navigator.push(context, MaterialPageRoute(builder: (context) => DailyTaskPage(index: index)));
        },
        child: Container(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 2, right: 18),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.blueAccent,
                  Colors.cyanAccent
                ]
              ),
          ),
          width: 195,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cardName,
                style: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10,),
              CircularPercentIndicator(
                backgroundColor: Colors.white,
                animation: true,
                animationDuration: 1800,
                lineWidth: 6,
                percent: todosProgress,
                progressColor: Colors.lightBlueAccent,
                radius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
