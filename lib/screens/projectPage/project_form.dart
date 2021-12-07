import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProjectForm extends StatefulWidget {

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {

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
              'Create a new project',
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            initialValue: "",
            decoration: textInputDecoration.copyWith(hintText: "Fancy project name"),
            validator: (val) => val!.isEmpty ? 'Please enter a project name' : null,
            onChanged: (val) => setState(()=> userInput = val),
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
                await DataBaseService(uid: user.uid).createProject(
                    userInput, false, [], [user.uid]);
                Navigator.pop(context);
              }

            },
          )
        ],
      ),
    );
  }
}