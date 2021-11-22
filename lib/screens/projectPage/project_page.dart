import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatefulWidget {
  
  int index; 

  ProjectPage({required this.index}); 

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserMod?>(context);
    final projects = Provider.of<List<Project>?>(context) ?? [] ;
    DataBaseService service = DataBaseService(uid: user!.uid); 
    return Material(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 60,),
            // Freund einladen

            //
            Container(
              child: Column(
                children: [
                  for(int i=0; i<projects[widget.index].data.length; i++)
                    Card(
                      child: Center(
                        child: Text("${projects[widget.index].data[i]}"),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: (){
          List<int> currentData = projects[widget.index].data; 
          currentData.add(1); 
          service.updateProjects(projects[widget.index].name, true, currentData); 
        },
      ),
      ),
      
    );
  }
}