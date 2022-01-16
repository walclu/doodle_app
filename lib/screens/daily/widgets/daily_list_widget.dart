import 'package:doodle_app/models/daily_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DailyList extends StatefulWidget {
  const DailyList({Key? key}) : super(key: key);

  @override
  _DailyListState createState() => _DailyListState();
}

class _DailyListState extends State<DailyList> {
  @override
  Widget build(BuildContext context) {
    final dailys = Provider.of<List<DailyTask>?>(context) ?? [];
    return Container();
  }
}
