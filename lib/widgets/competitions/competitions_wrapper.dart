import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:doodle_app/widgets/competitions/competitions_overview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompetitionsWrapper extends StatefulWidget {
  const CompetitionsWrapper({ Key? key }) : super(key: key);

  @override
  State<CompetitionsWrapper> createState() => _CompetitionsWrapperState();
}

class _CompetitionsWrapperState extends State<CompetitionsWrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod?>(context);
    return StreamProvider<List<DailyTaskFirestore>?>.value(
      value:DataBaseService(uid:user!.uid).dailyTaskListStream,
      initialData: const [],
      child: CompetitionsOverview(),
    );
  }
}