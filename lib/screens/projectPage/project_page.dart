import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/projectPage/settings_form.dart';
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
    final projects = Provider.of<List<Project>?>(context) ?? [];
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding:  EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(projectCopy: projects[widget.index],),
        );
      });
    }
    DataBaseService service = DataBaseService(uid: user!.uid);
    return Material(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "Search for users"),
                        validator: (val) => val!.isEmpty
                            ? 'Enter an email of your friend'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            search = val;
                          });
                        },
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await service.uidCollection.doc(search).get();
                        try {
                          await service.addUserToProject(
                              result['uid'], projects[widget.index]);
                        } catch (e) {
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
                  for (int i = 0; i < projects[widget.index].todos.length; i++)
                    Container(
                      height: 50,
                      child: Card(
                        child: Center(
                          child: Text("${projects[widget.index].todos[i].name}"),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(onPressed: (){}, icon: Icon(Icons.list)),
     
              IconButton(onPressed: (){}, icon: Icon(Icons.vertical_align_bottom_outlined)),
            ],
          ),
          shape: CircularNotchedRectangle(),
          color: Colors.blueGrey,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _showSettingsPanel();
            });

          },
        ),
      ),
    );
  }
}
