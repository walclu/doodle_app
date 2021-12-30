import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/services/data_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProjectForm extends StatefulWidget {
  ProjectForm();

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  String userInput = "";

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

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
                decoration: const InputDecoration.collapsed(
                    hintText: "Enter project name"),
                validator: (val) =>
                    val!.isEmpty ? 'Please enter a valid name' : null,
                onChanged: (val) => setState(() => userInput = val),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: Color.fromRGBO(234, 239, 255, 1)),
                    color: Colors.white,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: MaterialPicker(
                              pickerColor: pickerColor,
                              onColorChanged: changeColor,
                             ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Choose'),
                                onPressed: () {
                                  setState(() {
                                    currentColor = pickerColor;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.circle_outlined,
                          color: currentColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Color',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
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
                      print(int.parse(currentColor.toString().substring(6,16)));
                      if (_formKey.currentState!.validate()) {
                        await DataBaseService(uid: user.uid)
                            .createProject(userInput, false, [], [user.uid], int.parse(currentColor.toString().substring(6,16)));
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create',
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
