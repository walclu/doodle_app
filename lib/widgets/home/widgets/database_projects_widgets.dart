import 'package:doodle_app/widgets/home/project_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';

class ProjectsListWidget extends StatefulWidget {
  const ProjectsListWidget({Key? key}) : super(key: key);

  @override
  _ProjectsListWidgetState createState() => _ProjectsListWidgetState();
}

class _ProjectsListWidgetState extends State<ProjectsListWidget> {
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
          return ProjectCard(index: it);
        },
      ),
    );
  }
}
