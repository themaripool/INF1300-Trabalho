
import 'package:flutter/material.dart';

class FourthPage extends StatelessWidget {

  final List dias;
  final int index;

  FourthPage(List this.dias, this.index);

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

           Text(
            dias[index]["diaSemana"] + " , " + dias[index]["intDiaSemana"],
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'RobotoMono',
              fontSize: 35,
            ),
          ),

          Divider(height: 20, color: Colors.white),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

            Container(
              padding: EdgeInsets.all(10),
              child:  Text(dias[index]["humor"]),
            ),
            
            OutlineButton(

              child: new Text("Editar Texto"),
              onPressed: null,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
            )
            ],
          ),

          Divider(height: 20, color: Colors.white),

          Container(
            width: 320,
            height: 250,
            color: Colors.amber,
          ),

          OutlineButton(

              child: new Text("Salvar Texto"),
              onPressed: null,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0))
            )
              
          
          ],
        )
      ),


     
    );
  }
}




