import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/widgets/todo/todo_list.dart';
import 'package:doodle_app/widgets/projectPage/widgets/settings_form.dart';
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

    DataBaseService service = DataBaseService(uid: user!.uid);
    return Material(
      color: Colors.grey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(249, 250, 255,1),
        body: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row( // Freund suchen
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
                          final projects = Provider.of<List<Project>?>(context) ?? [];

                          await service.addUserToProject(
                              result['uid'], projects[widget.index]);
                        } catch (e) {
                          print('Search failed');
                        }
                      }
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            TodoList(index: widget.index),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SettingsForm(projectIndex: widget.index);
            }));
          },
        ),
      ),
    );
  }
}
