import 'package:doodle_app/screens/home/project_tile.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';

class DatabaseProjectsWidget extends StatefulWidget {
  const DatabaseProjectsWidget({Key? key}) : super(key: key);

  @override
  _DatabaseProjectsWidgetState createState() => _DatabaseProjectsWidgetState();
}

class _DatabaseProjectsWidgetState extends State<DatabaseProjectsWidget> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context);
    final projects = Provider.of<List<Project>?>(context) ?? [];
    return Container(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: projects.length,
        itemBuilder: (context, it) {
          return ProjectTile(index: it);
        },
      ),
    );
  }
}
