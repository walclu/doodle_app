import 'package:doodle_app/services/auth_service.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:doodle_app/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = "";
  String password = "";
  String error = ""; 

  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      backgroundColor: primaryGreen,
      appBar: AppBar(
        backgroundColor: primaryGreen,
        elevation: 0.0,
        title: Text('Register to Toodoodle'),
        actions: [
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            label: Text("Sign in"), 
            icon: Icon(Icons.person),)
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
                decoration: getInputDecoration("Email"),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height:20.0), 
              TextFormField(
                decoration: getInputDecoration("Password"),
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
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        loading = false;
                        error = 'please supply a valid email';
                      });
                    } 
                  }
                }
                ), 
                SizedBox(height: 20,),
                Text(error),

              
            ],
            ),
        )
      ),
    );
  }
}
