import 'dart:math';

import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/shared/constants.dart';
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

    String cardName = index == 0 ?  "Your Dailys" : "XY Dailys";
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
    var rnd = Random();
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => DailyTaskPage(index: index)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
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
                numTodos == 1 ?
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("$numTodos task",
                    style: GoogleFonts.openSans(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ) :
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text("$numTodos tasks",
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
                  child: Text(cardName,
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
                  progressColor: index == 0 ? Colors.lightBlue : Colors.purple,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
