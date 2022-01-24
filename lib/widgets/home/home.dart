import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/widgets/home/home_layout.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod?>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<DailyTaskFirestore>?>.value(
          value:DataBaseService(uid:user!.uid).dailyTaskListStream,
          initialData: const [],
          catchError: (_, err) => null,
        ),
        StreamProvider<List<Project>?>.value(
          value: DataBaseService(uid: user.uid).projectListStream,
          initialData: const [],
          catchError: (_, err) => null,
        )
      ],
      child: const HomeLayout(),
    );
  }

}