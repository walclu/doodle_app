import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:doodle_app/widgets/home/widgets/daily_task_page.dart';
import 'package:doodle_app/widgets/home/widgets/daily_tasks_progress_list.dart';
import 'package:doodle_app/widgets/home/widgets/today_tasks_widget.dart';
import 'package:doodle_app/widgets/home/widgets/database_projects_widgets.dart';
import 'package:doodle_app/widgets/home/widgets/heading_welcome_widget.dart';
import 'package:doodle_app/widgets/home/widgets/test.dart';
import 'package:doodle_app/widgets/projectPage/widgets/project_form.dart';
import 'package:doodle_app/services/auth_service.dart';
import 'package:doodle_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  bool loggedIn = true;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context);

    final AuthService _auth = AuthService();
    return loggedIn
        ? MaterialApp(
            home: AnimatedContainer(
            decoration: isDrawerOpen
                ? BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  )
                : BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(1),
                  ),
            transform: Matrix4.translationValues(xOffset, yOffset, 0)
              ..scale(scaleFactor)
              ..rotateY(isDrawerOpen ? -0.5 : 0),
            duration: const Duration(milliseconds: 200),
            child: Material(
              child: Scaffold(
                backgroundColor: backGroundColor,//const Color.fromRGBO(14, 31, 84, 0.03),
                resizeToAvoidBottomInset: false,
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDrawerOpen
                                ? IconButton(
                                    icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white,),
                                    onPressed: () {
                                      setState(() {
                                        xOffset = 0;
                                        yOffset = 0;
                                        scaleFactor = 1;
                                        isDrawerOpen = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(Icons.menu,
                                    color: Colors.white,),
                                    onPressed: () {
                                      setState(() {
                                        xOffset = 230;
                                        yOffset = 150;
                                        scaleFactor = .6;
                                        isDrawerOpen = true;
                                      });
                                    }),
                            IconButton(
                                icon: const Icon(Icons.logout,
                                color: Colors.white,),
                                onPressed: () async {
                                  setState(() {
                                    loggedIn = false;
                                  });
                                  dynamic result = await _auth.signOut();
                                }),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.86,
                        padding: const EdgeInsets.all(25.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WelcomeWidget(uid: user.uid),
                              const SizedBox(
                                height: 25,
                              ),
                              Text("DAILYS",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const SizedBox(
                                height: 10,
                              ),
                              const DailyTasksProgressList(),
                              const SizedBox(
                                height: 25,
                              ),
                              Text("PROJECTS",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const SizedBox(height: 10),
                              const ProjectsListWidget(),
                              const SizedBox(
                                height: 30,
                              ),
                              Text("TODAY'S PROJECT TASKS",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const SizedBox(
                                height: 10,
                              ),
                              const TodayTasksList(),
                            ],
                          ),
                        ),
                      ),
                    ]),
                floatingActionButton: ExpandableFab(
                  distance: 112.0,
                  children: [
                    ActionButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProjectForm()));
                      },
                      icon: const Icon(Icons.add),
                    ),
                    ActionButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DailyTaskPage(index: 0)));
                      },
                      icon: const Icon(Icons.checklist_rtl_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ))
        : new Loading();
  }
}
