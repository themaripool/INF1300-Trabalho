
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';



class BreathingPage extends StatefulWidget {
  // BreathingPage({Key key, this.title, this.i}) : super(key: key);

  final int index;


  BreathingPage(this.index);

  @override
  _BreathingPageState createState() => _BreathingPageState();
}

class _BreathingPageState extends State<BreathingPage> {

  List respiracoes;
 
  Future<String> loadJsonData() async {
    
    var jsonText = await rootBundle.loadString('assets/breathingPage.json');

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
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey),
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
              "assets/squareBreathing.gif",
              height: 450.0,
              width: 450.0,
            )
      ])),
    );
  }
}
