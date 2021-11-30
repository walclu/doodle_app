import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/home/project_tile.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
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
    final projects = Provider.of<List<Project>?>(context) ?? [];
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'Good afternoon,',
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat',
            fontSize: 30,
          ),
          ),
          Text(user.uid,
            style: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15,
              color: Colors.lightBlue,
            ),
          ),
          SizedBox(height:10),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: shadowList,
            ),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Daily tasks',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked1 = value!;
                            });
                          },
                        ),
                        Text('Daily Task 1',
                          style: TextStyle(
                            color: isChecked1 ? Colors.grey : Colors.white ,
                            decoration: isChecked1 ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked2 = value!;
                            });
                          },
                        ),
                        Text('Daily Task 2',
                          style: TextStyle(
                            color: isChecked2 ? Colors.grey : Colors.white ,
                            decoration: isChecked2 ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked3,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked3 = value!;
                            });
                          },
                        ),
                        Text('Daily Task 3',
                          style: TextStyle(
                            color: isChecked3 ? Colors.grey : Colors.white ,
                            decoration: isChecked3 ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height:50),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: projects.length,
              itemBuilder: (context, it) {
                return ProjectTile(project: projects[it], index: it);
              },
            ),
          ),
        ],
      ),
    );
    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: projects.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return ProjectTile(project: projects[index]);
    // }
    // );
    // return Expanded(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         for(int i = 0; i<projects.length; i++)
    //           ProjectTile(project: projects[i], index: i),
    //       ],
    //     ),
    //   ),
    // );
  }
}


