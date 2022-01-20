import 'package:doodle_app/models/daily_task.dart';
import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/daily/daily_form.dart';
import 'package:doodle_app/screens/home/home_layout.dart';
import 'package:doodle_app/screens/projectPage/project_form.dart';
import 'package:doodle_app/services/auth_service.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:doodle_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/screens/home/widgets/test.dart';

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
          initialData: [],
          catchError: (_, err) => null,
        ),
        StreamProvider<List<Project>?>.value(
          value: DataBaseService(uid: user.uid).projectListStream,
          initialData: [],
          catchError: (_, err) => null,
        )
      ],
      child: HomeLayout(),
    );
  }

}