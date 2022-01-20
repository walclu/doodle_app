import 'package:doodle_app/models/daily_task.dart';
import 'package:doodle_app/models/dailytaskfirestore.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/daily/widgets/daily_list_widget.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DailyForm extends StatefulWidget {
  List<DailyTaskFirestore> dailyTasks;

  DailyForm({required this.dailyTasks});

  @override
  _DailyFormState createState() => _DailyFormState();
}

class _DailyFormState extends State<DailyForm> {
  final _formKey = GlobalKey<FormState>();
  String userInput = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context);
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
              //DailyList(),
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
                    hintText: "Enter daily task"),
                validator: (val) => val!.isEmpty ? 'Please enter a text' : null,
                onChanged: (val) => setState(() => userInput = val),
              ),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
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
                        for (DailyTaskFirestore firestoreObject
                            in widget.dailyTasks) {
                          if (firestoreObject.permissions[0] == user.uid) {
                            List<DailyTask> myDailies = firestoreObject.dailies;
                            myDailies
                                .add(DailyTask(name: userInput, done: false));
                            await DataBaseService(uid: user.uid)
                                .updateDailyTask(DailyTaskFirestore(
                                    dailies: myDailies,
                                    permissions: firestoreObject.permissions));
                          }
                        }
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
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
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
