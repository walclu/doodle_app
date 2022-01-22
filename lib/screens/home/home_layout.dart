import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/daily/daily_form.dart';
import 'package:doodle_app/screens/home/project_tile.dart';
import 'package:doodle_app/screens/home/widgets/daily_task_page.dart';
import 'package:doodle_app/screens/home/widgets/daily_tasks_progress_list.dart';
import 'package:doodle_app/screens/home/widgets/daily_tasks_widget.dart';
import 'package:doodle_app/screens/home/widgets/database_projects_widgets.dart';
import 'package:doodle_app/screens/home/widgets/heading_welcome_widget.dart';
import 'package:doodle_app/screens/home/widgets/test.dart';
import 'package:doodle_app/screens/projectPage/project_form.dart';
import 'package:doodle_app/services/auth_service.dart';
import 'package:doodle_app/shared/constants.dart';
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
    final dailyTaskFirestore = Provider.of<List<DailyTaskFirestore>?>(context) ?? [];

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
            duration: Duration(milliseconds: 200),
            child: Material(
              child: Scaffold(
                backgroundColor: Color.fromRGBO(14, 31, 84, 0.03),
                resizeToAvoidBottomInset: false,
                body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDrawerOpen
                                ? IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
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
                                    icon: Icon(Icons.menu),
                                    onPressed: () {
                                      setState(() {
                                        xOffset = 230;
                                        yOffset = 150;
                                        scaleFactor = .6;
                                        isDrawerOpen = true;
                                      });
                                    }),
                            IconButton(
                                icon: Icon(Icons.logout),
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
                                      color: Colors.grey[500])),
                              const SizedBox(
                                height: 10,
                              ),
                              DailyTasksProgressList(),
                              const SizedBox(
                                height: 25,
                              ),
                              Text("PROJECTS",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500])),
                              const SizedBox(height: 10),
                              DatabaseProjectsWidget(),
                              const SizedBox(
                                height: 30,
                              ),
                              Text("TODAY'S PROJECT TASKS",
                                  style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[500])),
                              const SizedBox(
                                height: 10,
                              ),
                              DailyTasksWidget(),
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
                      onPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DailyTaskPage(index: 0))
                        );
                      },
                      icon: const Icon(Icons.checklist_rtl_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ))
        : Loading();
  }
}
