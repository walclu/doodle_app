import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatefulWidget {
  
  int index;

  ProjectPage({required this.index}); 

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {

  final _formKey = GlobalKey<FormState>();
  String search = '';
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserMod?>(context);
    final projects = Provider.of<List<Project>?>(context) ?? [] ;
    print(projects); 
    DataBaseService service = DataBaseService(uid: user!.uid);
    return Material(
      child: Scaffold(
        body: Column(
          children: [
            // Freund einladen
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                      decoration: textInputDecoration.copyWith(hintText: "Search for users"),
                        validator: (val) => val!.isEmpty ? 'Enter an email of your friend' : null,
                        onChanged: (val){
                          setState(() {
                            search = val;
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          dynamic result = await service.uidCollection.doc(search).get();
                          try {
                            await service.addUserToProject(result['uid'], projects[widget.index]); 
                          } catch(e){
                            print('Search failed');
                          }
                        }
                      },
                      icon: Icon(Icons.search),
                  ),

                ],
              ),
            ),
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
        child: Icon(Icons.add),
        onPressed: (){
          List<int> currentData = projects[widget.index].data; 
          currentData.add(1); 
          service.updateProject(projects[widget.index].name, true, currentData, projects[widget.index].userPermissions);
        },
      ),
      ),
      
    );
  }
}