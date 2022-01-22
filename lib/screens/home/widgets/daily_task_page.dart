import 'package:doodle_app/models/daily_task.dart';
import 'package:doodle_app/models/daily_task_firestore.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/daily/daily_form.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class DailyTaskPage extends StatefulWidget {
  final int index;

  DailyTaskPage({required this.index});

  @override
  _DailyTaskPageState createState() => _DailyTaskPageState();
}

class _DailyTaskPageState extends State<DailyTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String search = '';

  Future _refresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {

    });
    print("Hello world");
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMod?>(context);
    final dailyTaskFirestore = Provider.of<List<DailyTaskFirestore>?>(context) ?? [];
    DailyTaskFirestore firebaseDoc = dailyTaskFirestore[widget.index];
    DataBaseService service = DataBaseService(uid: user!.uid);

    List<DailyTask> dailyTasks = firebaseDoc.dailies;
    bool owner = user.uid==firebaseDoc.permissions[0];
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: owner ? Row(
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
                    onPressed: owner? () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await service.uidCollection.doc(search).get();
                        try {
                          // await service.addUserToDailyTasks();
                        } catch (e) {
                          print('Search failed');
                        }
                      }
                    } : () async{},
                    icon: const Icon(Icons.search),
                  ),
                ],
              ) : SizedBox(height: 20,),
            ),

            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ReorderableListView.builder(

                    onReorder: owner ? (oldIndex, newIndex) async {
                      setState(() {
                        final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                        final task = dailyTasks.removeAt(oldIndex);
                        dailyTasks.insert(index, task);
                      });
                      firebaseDoc.dailies = dailyTasks;
                      await DataBaseService(uid: user.uid).updateDailyTask(
                         firebaseDoc
                      );
                    } : (oldIndex, newIndex){

                    },
                    itemCount: dailyTasks.length,
                    itemBuilder: (context, it) {
                      return GestureDetector(
                        key: ValueKey(dailyTasks[it]),
                        onDoubleTap: () async {
                        },
                        onTap: owner? () async {
                          dailyTasks[it].done = !dailyTasks[it].done;
                          firebaseDoc.dailies = dailyTasks;
                          await DataBaseService(uid: user.uid).updateDailyTask(
                             firebaseDoc
                          );
                          setState(() {});
                        } : () async{},
                        child: owner? Dismissible(

                          key: ValueKey(dailyTasks[it]),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
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
                           DailyTask safe = dailyTasks.removeAt(it);
                           firebaseDoc.dailies = dailyTasks;
                           await service.updateDailyTask(
                             firebaseDoc
                           );

                            setState(() {});
                            final snackBar = SnackBar(
                              content: const Text('Task deleted'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () async {
                                  dailyTasks.insert(it, safe);
                                  firebaseDoc.dailies = dailyTasks;
                                  await service.updateDailyTask(
                                    firebaseDoc
                                  );
                                  setState(() {});
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.circle_outlined,
                                  color: Colors.blue,
                                ),
                                const SizedBox(
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
                        ): Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.circle_outlined,
                                color: Colors.blue,
                              ),
                              const SizedBox(
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
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: owner?  FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DailyForm(firebaseDoc: firebaseDoc))
            );
            setState(() {

            });
            },
        ) : null,
      ),
    );
  }
}
