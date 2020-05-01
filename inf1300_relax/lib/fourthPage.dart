import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FourthPage extends StatelessWidget {

  final List dias;
  final int index;
  final List diario;
  

  FourthPage(List this.dias, this.index, List this.diario);

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
              fontFamily: 'OpenSans',
              fontStyle: FontStyle.italic,
              fontSize: 25,
            ),
          ),

          Divider(height: 20, color: Colors.transparent),

          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Row(
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
          ),

          

          Divider(height: 15, color: Colors.transparent),

          //Texto do diário dentro de container scrolável

          Container(
            width: 320,
            height: 300,
            margin: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: Color.fromRGBO(248, 248, 255, 1),
              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1),
              borderRadius: new BorderRadius.all(Radius.circular(10))
            ),
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SingleChildScrollView(
                child: Text(diario[index]["texto"]),
              ),
            )
          ),

          Divider(height: 10, color: Colors.transparent),

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




