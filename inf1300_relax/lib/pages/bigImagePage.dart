import 'package:flutter/material.dart';




class BigImagePage extends StatefulWidget {
  BigImagePage({Key key, this.title, @required this.image}) : super(key: key);

  final String title;
  final String image;

  @override
  _BigImagePageState createState() => _BigImagePageState();


}

class _BigImagePageState extends State<BigImagePage> {
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
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey)
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