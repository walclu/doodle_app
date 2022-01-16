import 'package:doodle_app/screens/daily/daily_form.dart';
import 'package:flutter/material.dart';

class Fuck extends StatefulWidget {
  const Fuck({Key? key}) : super(key: key);

  @override
  _FuckState createState() => _FuckState();
}

class _FuckState extends State<Fuck> {
  @override
  Widget build(BuildContext context) {
    return Material( child: DailyForm());
  }
}
