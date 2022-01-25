import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color backGroundColor = Color.fromRGBO(36, 31, 65, 1);
Color primaryGreen = Colors.white;
List<BoxShadow> shadowList = [
  BoxShadow(
      color: Colors.blue, blurRadius: 2, offset: Offset(5, 5), spreadRadius: 1)
];

List<List<Color>> colorPalette = [
  [Colors.pinkAccent,
    Color.fromRGBO(87, 47, 135, 1),],
  [Color.fromRGBO(73, 43, 191, 1),
    Color.fromRGBO(134, 112, 223, 1)],
  [Color.fromRGBO(192, 93, 89, 1),
    Color.fromRGBO(164, 40, 53, 1)],
];

InputDecoration getInputDecoration(String emailOrPassword) {
  return InputDecoration(
    hintText: emailOrPassword,
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0)),
  );
}

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey, width: 2.0)),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

List<Map> categories = [
  {'name': 'Cats', 'iconPath': 'images/cat.png'},
  {'name': 'Dogs', 'iconPath': 'images/dog.png'},
  {'name': 'Bunnies', 'iconPath': 'images/rabbit.png'},
  {'name': 'Parrots', 'iconPath': 'images/parrot.png'},
  {'name': 'Horses', 'iconPath': 'images/horse.png'}
];

List<Map> animalPicturePath = [
  {'name': 'Cat1', 'imagePath': 'images/pet-cat2.png'},
  {'name': 'Cat2', 'imagePath': 'images/pet-cat1.png'},
];

List<Map> drawerItems = [
  {'icon': FontAwesomeIcons.paw, 'title': 'Adoption'},
  {'icon': Icons.mail, 'title': 'Donation'},
  {'icon': FontAwesomeIcons.plus, 'title': 'Add pet'},
  {'icon': Icons.favorite, 'title': 'Favorites'},
  {'icon': Icons.mail, 'title': 'Messages'},
  {'icon': FontAwesomeIcons.userAlt, 'title': 'Profile'},
];

TextStyle style = TextStyle(
  fontFamily: 'OpenSans',
);
