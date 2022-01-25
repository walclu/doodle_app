import 'package:doodle_app/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animated_icon/simple_animated_icon.dart';


class TodoWidgetUi extends StatefulWidget {

  Todo todo;
  TodoWidgetUi({required this.todo});


  @override
  State<TodoWidgetUi> createState() => _TodoWidgetUiState();
}

class _TodoWidgetUiState extends State<TodoWidgetUi> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progress;



  @override
  void initState() {
    super.initState();
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      });
    _progress = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.todo.state){
      _animationController.forward();
    }
    else{
      _animationController.reverse();
    }

    return GestureDetector(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white
          ),
          width: MediaQuery.of(context).size.width-30,
          height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SimpleAnimatedIcon(startIcon: Icons.circle_outlined, endIcon: Icons.check_outlined, progress: _progress),
              const SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.todo.name,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700]
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "  Start: ${widget.todo.whenToStart.substring(0,10)}",
                    style: GoogleFonts.openSans(
                      fontSize: 10,
                    ),
                    ),
                                  Text(
                    "End: ${widget.todo.whenToBeDone.substring(0,10)}",
                    style: GoogleFonts.openSans(
                      fontSize: 10,
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


