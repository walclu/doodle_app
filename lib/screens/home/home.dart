import 'package:flutter/material.dart';
import 'package:doodle_app/shared/constants.dart';
import 'package:doodle_app/screens/drawerScreen/drawerScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: isDrawerOpen? BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ) :BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(1),
      ),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)..rotateY(isDrawerOpen?-0.5:0),
      duration: Duration(milliseconds: 200),
      child: 
      
      Material(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = .6;
                              isDrawerOpen = true;
                            });
                          }),
                ],
      
              ),
              
            ),
      
                        SizedBox(
              height: 60,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 12,
              )
            )
           
          ]
        ),
      ),
    );
  }
}
