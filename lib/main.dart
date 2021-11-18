import 'package:doodle_app/services/auth_service.dart';
import 'package:doodle_app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'models/user_mod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserMod?>.value(
      value: AuthService().userModStream,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}