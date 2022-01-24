import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/widgets/home/widgets/daily_progress_circle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class DailyTasksProgressList extends StatefulWidget {
  const DailyTasksProgressList({Key? key}) : super(key: key);

  @override
  _DailyTasksProgressListState createState() => _DailyTasksProgressListState();
}

class _DailyTasksProgressListState extends State<DailyTasksProgressList> {
  @override
  Widget build(BuildContext context) {
    final dailyTaskFirestore = Provider.of<List<DailyTaskFirestore>?>(context) ?? [];

    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dailyTaskFirestore.length,
        itemBuilder: (context, it) {
          return DailyProgressCircle(index: it);
        },
      ),
    );
  }
}
