import 'package:doodle_app/screens/home/project_tile.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';

class WelcomeWidget extends StatelessWidget {
  WelcomeWidget({required this.uid}); 
  String uid; 

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good afternoon,',
          style: style.copyWith(fontSize: 30, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        Text(uid,
            style: style.copyWith(fontSize: 15, color: Colors.lightBlue)
          ),
      ],
    );
  }
}
