import 'package:doodle_app/models/project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/screens/home/project_tile.dart';

class ProjectList extends StatefulWidget {
  const ProjectList({Key? key}) : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {

    final projects = Provider.of<List<Project>?>(context) ?? [];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return ProjectTile(project: projects[index]);
    });
  }
}


