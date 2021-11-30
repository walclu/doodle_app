import 'package:doodle_app/screens/projectPage/project_page.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/models/project.dart';

class ProjectTile extends StatelessWidget {
  //const ProjectTile({Key? key}) : super(key: key);

  final Project project;
  final int index; 
  ProjectTile({required this.project, required this.index});

  String _getProjectName(String name){
    int indexUnderscore = name.indexOf('_');
    return name.substring(0,indexUnderscore);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectPage(index: index))); 
      },
      child: Container(
        width: 200,
        child: Card(
          child: Text(_getProjectName(project.name)),
        ),
      ),
    );
  }
}
