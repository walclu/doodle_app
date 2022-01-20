import 'package:doodle_app/models/dailytaskfirestore.dart';
import 'package:doodle_app/screens/home/project_tile.dart';
import 'package:doodle_app/screens/home/widgets/daily_progress_circle.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';



class DailyTasksProgressList extends StatefulWidget {
  const DailyTasksProgressList({Key? key}) : super(key: key);

  @override
  _DailyTasksProgressListState createState() => _DailyTasksProgressListState();
}

class _DailyTasksProgressListState extends State<DailyTasksProgressList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context);
    final dailyTaskFirestore = Provider.of<List<DailyTaskFirestore>?>(context) ?? [];

    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dailyTaskFirestore.length,
        itemBuilder: (context, it) {
          return DailyProgressCircle(index: it, dailyTasksFirestore: dailyTaskFirestore);
        },
      ),
    );
  }
}
