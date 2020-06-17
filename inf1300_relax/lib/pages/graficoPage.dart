
import 'package:flutter/material.dart';
import 'package:fcharts/fcharts.dart';



class GraficoPage extends StatefulWidget {
  GraficoPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GraficoPageState createState() => _GraficoPageState();
}

class _GraficoPageState extends State<GraficoPage> {

  static const myData = [
    ["Seg", "😁"],
    ["Ter", "😑"],
    ["Qua", "😁"],
    ["Qui", "😔"],
    ["Sex", "😑"],
    ["Sáb", "😔"],
    ["Dom", "😁"],
  ];
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(

          children: <Widget>[

            Divider(height:10 ,color: Colors.transparent),

            Text(
              "Gráfico da semana",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),

            Divider(color: Colors.transparent),

            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                color: Color.fromRGBO(248, 248, 255, 1),
                borderRadius: new BorderRadius.all(Radius.circular(10))
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: LineChart(
                  lines: [
                    new Line<List<String>, String, String>( // max de 7 porque se repitir dia da semana buga
                      data: myData,
                      xFn: (datum) => datum[0],
                      yFn: (datum) => datum[1],
                    ),
                  ],
                ),
              )
            ),

            Divider(height: 10, color: Colors.transparent),

            Text(
              "Estatísticas da semana",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),

            Divider(height: 10, color: Colors.transparent),

            Text(
              '😔 -------------- 28,57%',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 15,
              ),
            ),

            Divider(color: Colors.transparent),

            Text(
              '😑 -------------- 28,57%',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 15,
              ),
            ),

            Divider(color: Colors.transparent),

            Text(
              '😁 -------------- 42,86%',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 15,
              ),
            ),

          ],
        )
      ),    
    );
  }
}






