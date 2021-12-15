import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/home/project_tile.dart';
import 'package:doodle_app/screens/home/widgets/daily_tasks_widget.dart';
import 'package:doodle_app/screens/home/widgets/database_projects_widgets.dart';
import 'package:doodle_app/screens/home/widgets/heading_welcome_widget.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context); 
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeWidget(uid: user.uid),
          SizedBox(height: 25,), 
          Text(
            "CATEGORIES", 
            style: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.bold, 
              color: Colors.grey[500]
            )
            ), 
          SizedBox(height:10),
          DatabaseProjectsWidget(),
          SizedBox(height: 30,),
          Text(
              "TODAY'S TASKS",
              style: GoogleFonts.openSans(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500]
              )
          ),
          SizedBox(height: 10,),
          DailyTasksWidget(),

        ],
      ),
    );
  }
}


