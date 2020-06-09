import 'package:flutter/material.dart';

class SquareRespirationPage extends StatefulWidget {
  SquareRespirationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SquareRespirationPageState createState() => _SquareRespirationPageState();
}

class _SquareRespirationPageState extends State<SquareRespirationPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ],
        leading: new Container(),
      ),
      body: Center(
          child: Column(children: <Widget>[

            Text(
              "Respiração Quadrada",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),

            Image.asset(
              "assets/squareRespiration.gif",
              height: 450.0,
              width: 450.0,
            )
      ])),
    );
  }
}
