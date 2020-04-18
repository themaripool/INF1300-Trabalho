
import 'package:flutter/material.dart';


class FourthPage extends StatefulWidget {
  FourthPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
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
      body: Center(
        child: Column(

          children: <Widget>[

            Text("OLAR")
          
          ],
        )
      ),


     
    );
  }
}




