import 'package:doodle_app/models/inv_project.dart';
import 'package:doodle_app/models/project.dart';
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

    final projects = Provider.of<List<Project>?>(context) ?? [];
    final invProjects = Provider.of<List<InvProject>?>(context) ?? [];
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
            for(int i = 0; i<invProjects.length; i++)
              InvProjectTile(project: invProjects[i], index: i)
          ],
        ),
      ),
    ); 
  }
}


