import 'package:doodle_app/models/daily_task.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/todo.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/daily/daily_form.dart';
import 'package:doodle_app/screens/projectPage/widgets/todo_overview_widget.dart';
import 'package:doodle_app/screens/projectPage/widgets/settings_form.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DailyTaskPage extends StatefulWidget {
  final dailyTasksFirestore;

  DailyTaskPage({required this.dailyTasksFirestore});

  @override
  _DailyTaskPageState createState() => _DailyTaskPageState();
}

class _DailyTaskPageState extends State<DailyTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String search = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod?>(context);
    DataBaseService service = DataBaseService(uid: user!.uid);
    //TODO Immoment wird immer nur die erste Liste an daily tasks gelesen -> Index erforderlich, damit man weiß welche Liste in der DailyTaskPage gezeigt werden soll
    List<DailyTask> dailyTasks = widget.dailyTasksFirestore[0].dailies;
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                          // await service.addUserToDailyTasks();
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

            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) async {
                    //TODO Implement reordering on device and on database
                    setState(() {});
                  },
                  itemCount: dailyTasks.length,
                  itemBuilder: (context, it) {
                    return GestureDetector(
                      key: ValueKey(dailyTasks[it]),
                      onDoubleTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DailyForm(dailyTasks: widget.dailyTasksFirestore)));
                      },
                      onTap: () async {
                        //TODO Toogle "done" on pressed daily task
                        setState(() {});
                      },
                      child: Dismissible(
                        key: ValueKey(dailyTasks[it]),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.redAccent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Delete",
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onDismissed: (direction) async {
                          //TODO delete dismissed object from database, but keep a copy of it for the snack bar, so user can bring it back
                          setState(() {});
                          final snackBar = SnackBar(
                            content: const Text('Task deleted'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () async {
                                //TODO take safed object and write it back to database
                                setState(() {});
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                dailyTasks[it].name,
                                style: GoogleFonts.openSans(
                                  decoration: dailyTasks[it].done
                                      ? TextDecoration.lineThrough
                                      : null,
                                  fontSize: 13,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DailyForm(dailyTasks: widget.dailyTasksFirestore);
            }));
          },
        ),
      ),
    );
  }
}
