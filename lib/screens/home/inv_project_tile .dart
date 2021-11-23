import 'package:doodle_app/models/inv_project.dart';
import 'package:doodle_app/screens/projectPage/project_page.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/models/project.dart';

class InvProjectTile extends StatelessWidget {
  //const ProjectTile({Key? key}) : super(key: key);

  final InvProject project;
  final int index; 
  InvProjectTile({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectPage(index: index))); 
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
            ),
            title: Text(project.name),
            subtitle: project.done ? Text('Finished') : Text('Pending'),
          ),
        ),
      ),
    );
  }
}
