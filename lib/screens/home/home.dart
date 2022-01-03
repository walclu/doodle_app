import 'package:doodle_app/models/daily_task.dart';
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
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  bool loggedIn = true;

  final _formKey = GlobalKey<FormState>();
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];
  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<UserMod?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<Project>?>.value(
          value: DataBaseService(uid: user!.uid).projectListStream,
          initialData: [],
          //catchError: (_, err) => null,
        ),
        StreamProvider<List<DailyTask>>.value(
          value:DataBaseService(uid:user.uid).dailyTaskListStream,
            initialData: [],
        )
      ],
      child: loggedIn
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
                    HomeLayout(),
                  ]),
              floatingActionButton: ExpandableFab(
                distance: 112.0,
                children: [
                  ActionButton(
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectForm()));
                    },
                    icon: const Icon(Icons.add),
                  ),
                  ActionButton(
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DailyForm()));
                    },
                    icon: const Icon(Icons.checklist_rtl_rounded),
                  ),
                 /*
                  ActionButton(
                    onPressed: () => _showAction(context, 1),
                    icon: const Icon(Icons.group_rounded),
                  ),

                  */

                ],
              ),
            ),
          ),
        ),
      )
          : Loading(),
    );
  }

Future<void> _showSettingsPanel(context, uid) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: ProjectForm(),
          );
        });
  }

  Future<void> _addProject(context, uid) async {
    String projectName = '';
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new project'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (val) =>
                    val!.isEmpty ? "Enter valid name" : null,
                    onChanged: (val) {
                      projectName = val;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Create'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await DataBaseService(uid: uid)
                      .createProject(projectName, false, [], [uid], 0);
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}