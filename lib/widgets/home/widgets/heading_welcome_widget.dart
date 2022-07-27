import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeWidget extends StatelessWidget {
  WelcomeWidget({required this.uid}); 
  String uid; 

  @override
  Widget build(BuildContext context) {

    return Text(
      'What\'s up, Furkan!',
      style: GoogleFonts.openSans(
        fontSize : 30, 
        color: Colors.white,
        fontWeight: FontWeight.bold, 
        ),
    );
  }
}
