import 'package:doodle_app/models/project.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoOverView extends StatefulWidget {
  final int index;

  TodoOverView({required this.index});

  @override
  _TodoOverViewState createState() => _TodoOverViewState();
}

class _TodoOverViewState extends State<TodoOverView> {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Project>?>(context) ?? [];
    print(projects[widget.index].todos.length);
    return Container(
      height: MediaQuery.of(context).size.height*0.72,
      child: ListView.builder(
          itemCount: projects[widget.index].todos.length,
          itemBuilder: (context, it) {
            return Container(
              margin: EdgeInsets.all(5),
              child: Card(
                child: Center(
                  child: Text("${projects[widget.index].todos[it].name}"),
                ),
              ),
            );
          }),
    );
  }
}
