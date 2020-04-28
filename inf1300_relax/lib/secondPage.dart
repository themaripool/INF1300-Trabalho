
import 'package:flutter/material.dart';
import 'thirdPage.dart';
import 'package:fcharts/fcharts.dart';



class SecongPage extends StatefulWidget {
  SecongPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecongPageState createState() => _SecongPageState();
}

class _SecongPageState extends State<SecongPage> {

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

            Divider(),

            Container(

              width: 300,
              height: 250,

              child:
              LineChart(
                
                lines: [
                  new Line<List<String>, String, String>( // max de 7 porque se repitir dia da semana buga
                    data: myData,
                    xFn: (datum) => datum[0],
                    yFn: (datum) => datum[1],
                  ),
                ],
              ),
            ),

            Divider(),

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
                'Ir para histórico de humor',
                style: TextStyle(fontSize: 20)
              ),
            ),
          ],
        )
      ),    
    );
  }
}






