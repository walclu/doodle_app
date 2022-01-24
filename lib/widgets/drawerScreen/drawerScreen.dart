import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart'; 

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:70,bottom: 70, left: 10),
      color: primaryGreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Lukas Walczak',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                      'Active Status',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                      ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: drawerItems.map((element) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(element['icon'],color: Colors.white,size: 20,),
                  SizedBox(width: 10,),
                  Text(element['title'],style: TextStyle(color: Colors.white,fontSize: 20))
                ],
              ),
            )).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings, color: Colors.white),
              SizedBox(width: 10,),
              Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: 10,),
              Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}
