import 'package:doodle_app/models/inv_project.dart';
import 'package:doodle_app/models/permissions.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/home/project_list.dart';
import 'package:doodle_app/services/auth_service.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:doodle_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:doodle_app/screens/drawerScreen/drawerScreen.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<UserMod?>(context);

    return MultiProvider(
      providers: [
        StreamProvider<List<Project>?>.value(
          value: DataBaseService(uid: user!.uid).projectListStream,
          initialData: [],
          // catchError: (_, err) => null,
        ),
        StreamProvider<List<Permission>?>.value(
          value: DataBaseService(uid: user.uid).permissionListStream,
          initialData: [],
          // catchError: (_, err) => null,
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
                    body: Column(children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          const Text(
                            'ToDoodle',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
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

                      //SizedBox(height:20),
                      ProjectList(),
                    ]),
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {
                        _addProject(context, user.uid);
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ),
              ),
            )
          : Loading(),
    );
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
                      .updateProjects(projectName, false, [], []);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
