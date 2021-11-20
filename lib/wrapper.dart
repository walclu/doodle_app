import 'package:doodle_app/models/user_mod.dart';
import 'package:doodle_app/screens/home/home.dart';
import 'package:doodle_app/screens/Authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserMod?>(context);

    return user==null? Authenticate() : HomeScreen();
  }
}
