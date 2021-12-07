import 'package:doodle_app/screens/home/project_tile.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:doodle_app/models/project.dart';
import 'package:doodle_app/models/user_mod.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeWidget extends StatelessWidget {
  WelcomeWidget({required this.uid}); 
  String uid; 

  @override
  Widget build(BuildContext context) {

    return Text(
      'What\'s up, Furk!',
      style: GoogleFonts.openSans(
        fontSize : 30, 
        color: Colors.grey[850], 
        fontWeight: FontWeight.bold, 
        ),
    );
  }
}
