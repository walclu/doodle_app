import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/home/project_list.dart';
import 'package:doodle_app/services/data_base.dart';
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod?>(context);

    return StreamProvider<List<Project>?>.value(
      value: DataBaseService(uid: user!.uid).projectListStream,
      initialData: [],
      child: AnimatedContainer(
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
            body:
                SingleChildScrollView(
                  child: Column(
                      children: [
                        SizedBox(height:50),
                        Row(
                          children: [
                            isDrawerOpen ? IconButton(
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                setState(() {
                                  xOffset = 0;
                                  yOffset = 0;
                                  scaleFactor = 1;
                                  isDrawerOpen = false;
                                });
                              },
                            ) :
                            IconButton(
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
                          ],
                        ),

                        //SizedBox(height:20),
                        ProjectList(),
                      ]),
                ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _addProject(context, user.uid);
              },
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }
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
              TextFormField(
                onChanged: (val) {
                  projectName = val;
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Create'),
            onPressed: () async {
              await DataBaseService(uid: uid)
                  .updateProjects(projectName, false);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
