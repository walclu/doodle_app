import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  final int projectIndex;
  SettingsForm({required this.projectIndex});

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String userInput = "";
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);


  // void _selectTime() async {
  //   final TimeOfDay? newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _time = newTime;
  //       print(_time.toString());
  //     });
  //   }
  // }
  DateTime finalTime = DateTime.now().add(Duration(days: 1)); 
  DateTime startTime = DateTime.now().add(Duration(days: 0)); 

  Future<DateTime> _selectTime() async {
    DateTime selected = DateTime.now() ; 
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
    final projects = Provider.of<List<Project>?>(context) ?? [];
    Project project = projects[widget.projectIndex];
    String name = project.name;
    bool done = project.done;
    List<Todo> todos = project.todos;
    int color = project.color;
    final user = Provider.of<UserMod>(context);
    //final projects = Provider.of<List<Project>?>(context) ?? [];

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
                initialValue: "",
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
                        DateTime selectedTime = await _selectTime();
                        startTime = selectedTime; 
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
                        DateTime selectedTime = await _selectTime();
                        finalTime = selectedTime; 
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
                        Todo validTodo = Todo(
                            name: userInput,
                            state: false,
                            whenToStart: startTime.toString(),
                            whenToBeDone: finalTime.toString(),
                            members: []);
                        todos.add(validTodo);
                        await DataBaseService(uid: user.uid).updateProject(
                            project.name,
                            done,
                            todos,
                            project.userPermissions,
                            color
                        );
                      }
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'New Task',
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
