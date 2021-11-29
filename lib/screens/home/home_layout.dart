import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
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
            height: MediaQuery.of(context).size.height*0.2,
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
                    const Text('Daily tasks',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ],
                ),
              ),
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


