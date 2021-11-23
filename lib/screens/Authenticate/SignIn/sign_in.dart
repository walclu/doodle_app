import 'package:doodle_app/services/auth_service.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:doodle_app/shared/loading.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {

  
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String error = ""; 
  String email = "";
  String password = "";
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: primaryGreen,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        elevation: 0.0,
        title: Text('Sign in',
        style: TextStyle(color: Colors.black)),
        actions: [
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            label: Text("Register", style: TextStyle(color: Colors.black)),
            icon: Icon(Icons.app_registration),)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height:20.0), 
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                 validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height:20.0), 
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ), 
              SizedBox(height: 20,), 
              RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        loading = false;
                        error = 'please supply a valid email';
                      });
                    } 
                  }
                }
                )

              
            ],
            ),
        )
      ),
    );
  }
}
