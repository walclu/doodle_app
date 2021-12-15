import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:io';

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
  
  late DateTime oldStartTime; 
  late DateTime oldFinalTime; 

    Future<DateTime> _selectTime(DateTime initial) async {
    DateTime selected = initial;
    await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime.now().add(Duration(days: 365 * 100)),
    onConfirm: (date) {
      selected = date; 
    }, currentTime: DateTime.now(), locale: LocaleType.de);
          return selected;  
  }

  @override
 Widget build(BuildContext context) {
    String name = widget.project.name;
    bool done = widget.project.done;
    List<Todo> todos = widget.project.todos;
    oldFinalTime = DateTime.parse(widget.project.todos[widget.index].whenToBeDone); 
    oldStartTime = DateTime.parse(widget.project.todos[widget.index].whenToStart); 
    
    final user = Provider.of<UserMod>(context);
    //final projects = Provider.of<List<Pro ject>?>(context) ?? [];
    DateTime newStartTime = oldStartTime; 
    DateTime newFinalTime = oldFinalTime;
    return Material(
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.close_sharp,
                    color: Colors.grey[600],
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              TextFormField(
                initialValue: todos[widget.index].name,
                //decoration: textInputDecoration,
                decoration: const InputDecoration.collapsed(
                    hintText: "Enter todo name"),
                validator: (val) => val!.isEmpty ? 'Please enter a text' : null,
                onChanged: (val) => setState(() => userInput = val),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Color.fromRGBO(234, 239, 255, 1)),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        DateTime selectedTime = await _selectTime(oldStartTime);
                        newStartTime = selectedTime; 
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Start',
                          ),
                        ],
                      ),
                    ),
                  ),

                   Container(
                    width: 100,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(color: Color.fromRGBO(234, 239, 255, 1)),
                      color: Colors.white,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        DateTime selectedTime = await _selectTime(oldFinalTime);
                        newFinalTime = selectedTime; 
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Finish',
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 150,
                  padding: EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Colors.grey),
                    color: Colors.blueAccent,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        todos[widget.index].whenToBeDone = newFinalTime.toString(); 
                        todos[widget.index].whenToStart = newStartTime.toString();
                        todos[widget.index].name = userInput;
                        await DataBaseService(uid: user.uid).updateProject(
                            widget.project.name,
                            done,
                            todos,
                            widget.project.userPermissions,
                          widget.project.color
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Edit',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.expand_less_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

