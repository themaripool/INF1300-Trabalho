
import 'package:flutter/material.dart';
import 'thirdPage.dart';


class SecongPage extends StatefulWidget {
  SecongPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecongPageState createState() => _SecongPageState();
}

class _SecongPageState extends State<SecongPage> {
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

          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                 builder: (context) => ThirdPage (),
                ),  
              );
            },
            child: const Text(
              'Ir nivel 2 de push',
              style: TextStyle(fontSize: 20)
            ),
          ),

          ],



        )
      ),


    
    );
  }
}




