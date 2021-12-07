import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TodoForm extends StatefulWidget {

  Project project;
  int index;

  TodoForm({required this.project, required this.index});

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {

  final _formKey = GlobalKey<FormState>();
  String userInput = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context);
    return Form(
      key: _formKey,
      child:  Column(
        children: [
          Text(
            'Change todo settings',
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            initialValue: widget.project.todos[widget.index].name,
            decoration: textInputDecoration.copyWith(hintText: "Fancy todo name"),
            validator: (val) => val!.isEmpty ? 'Please enter a todo name' : null,
            onChanged: (val) => setState(()=> widget.project.todos[widget.index].name = val),
          ),
          SizedBox(height: 20,),

          RaisedButton(
            color: Colors.blue[400],
            child: Text(
              'Create',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if(_formKey.currentState!.validate()){
                await DataBaseService(uid: user.uid).updateProject(
                    widget.project.name,
                    widget.project.done,
                    widget.project.todos,
                    widget.project.userPermissions);
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
    );
  }
}