import 'package:flutter/material.dart';
import 'package:doodle_app/screens/Authenticate/Register/register.dart';
import 'package:doodle_app/screens/Authenticate/SignIn/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn? SignIn(toggleView: toggleView) : Register(toggleView: toggleView);
  }
}
