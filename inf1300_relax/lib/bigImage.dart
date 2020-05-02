import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';




class BigImage extends StatefulWidget {
  BigImage({Key key, this.title, @required this.image}) : super(key: key);

  final String title;
  final String image;

  @override
  _BigImageState createState() => _BigImageState();


}

class _BigImageState extends State<BigImage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relax'),
      ),
      body:SizedBox.expand(
        child: Container(
        padding: EdgeInsets.all(3),
        child: Image.network(
          widget.image, 
          fit:BoxFit.scaleDown)
        )
      )


    
    );
  }


}