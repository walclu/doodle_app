import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';

class DailyTasksWidget extends StatefulWidget {
  const DailyTasksWidget({ Key? key }) : super(key: key);

  @override
  _DailyTasksWidgetState createState() => _DailyTasksWidgetState();
}

class _DailyTasksWidgetState extends State<DailyTasksWidget> {
    bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod>(context); 
    final projects = Provider.of<List<Project>?>(context) ?? [];
    return  Container(
            height: MediaQuery.of(context).size.height*0.32,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              // boxShadow: shadowList,
            ),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Daily tasks',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked1,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked1 = value!;
                            });
                          },
                        ),
                        Text('Daily Task 1',
                          style: TextStyle(
                            color: isChecked1 ? Colors.grey : Colors.white ,
                            decoration: isChecked1 ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked2,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked2 = value!;
                            });
                          },
                        ),
                        Text('Daily Task 2',
                          style: TextStyle(
                            color: isChecked2 ? Colors.grey : Colors.white ,
                            decoration: isChecked2 ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isChecked3,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked3 = value!;
                            });
                          },
                        ),
                        Text('Daily Task 3',
                          style: TextStyle(
                            color: isChecked3 ? Colors.grey : Colors.white ,
                            decoration: isChecked3 ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}