import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  Project projectCopy;
  SettingsForm({required this.projectCopy});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  String userInput = "";


  @override
  Widget build(BuildContext context) {
    String name = widget.projectCopy.name;
    bool done = widget.projectCopy.done;
    List<Todo> todos = widget.projectCopy.todos;

    final user = Provider.of<UserMod>(context);
    //final projects = Provider.of<List<Project>?>(context) ?? [];

    return Form(
          key: _formKey, 
          child:  Column(
            children: [
              Text(
                'Add a new todo',
                style: TextStyle(fontSize:  18.0)
              ), 
              SizedBox(height: 20,), 
              TextFormField(
                initialValue: "",
                decoration: textInputDecoration,
                validator: (val) => val!.isEmpty ? 'Please enter a text' : null,
                onChanged: (val) => setState(()=> userInput = val),
              ), 
              SizedBox(height: 20,), 
              //dropdown


              SizedBox(height: 20,), 
              //slider

    
              RaisedButton(
                color: Colors.pink[400], 
                child: Text(
                  'Update', 
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    Todo validTodo = Todo(name: userInput, state: false, whenToBeDone: "0", members: []);
                    todos.add(validTodo);
                    await DataBaseService(uid: user.uid).updateProject(widget.projectCopy.name, done,
                        todos, widget.projectCopy.userPermissions);
                  }
                  Navigator.pop(context); 
                },
              )
            ],
          ),
        );
        }
}