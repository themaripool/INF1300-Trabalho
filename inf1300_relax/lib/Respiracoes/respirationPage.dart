
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';



class RespirationPage extends StatefulWidget {
  // RespirationPage({Key key, this.title, this.i}) : super(key: key);

  final int index;


  RespirationPage(this.index);

  @override
  _RespirationPageState createState() => _RespirationPageState();
}

class _RespirationPageState extends State<RespirationPage> {

  List respiracoes;
 
  Future<String> loadJsonData() async {
    
    var jsonText = await rootBundle.loadString('assets/repirationPage.json');

    setState(() {
      respiracoes = json.decode(jsonText);
    });

  }

  
  @override
  void initState() { // called before this render on screen
    this.loadJsonData();
  }

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

            Text(respiracoes[widget.index]["title"],
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
