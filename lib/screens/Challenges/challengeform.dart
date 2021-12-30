import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/projectPage/widgets/todo_overview_widget.dart';
import 'package:doodle_app/screens/projectPage/widgets/settings_form.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChallengeForm extends StatefulWidget {
  ChallengeForm();

  @override
  _ChallengeFormState createState() => _ChallengeFormState();
}

class _ChallengeFormState extends State<ChallengeForm> {
  final _formKey = GlobalKey<FormState>();
  String search = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod?>(context);
    final projects = Provider.of<List<Project>?>(context) ?? [];
    DataBaseService service = DataBaseService(uid: user!.uid);
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(),//TodoOverView(index: widget.index),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Container();
            }));
          },
        ),
      ),
    );
  }
}
