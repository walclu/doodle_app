import 'package:doodle_app/models/inv_project.dart';
import 'package:doodle_app/models/permission.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/screens/home/project_tile.dart';

import 'inv_project_tile .dart';

class ProjectList extends StatefulWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context); 
    final projects = Provider.of<List<Project>?>(context) ?? [];
    // return ListView.builder(
    //   shrinkWrap: true,
    //   itemCount: projects.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return ProjectTile(project: projects[index]);
    // }
    // );
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            for(int i = 0; i<projects.length; i++)
              ProjectTile(project: projects[i], index: i),
          ],
        ),
      ),
    ); 
  }
}


