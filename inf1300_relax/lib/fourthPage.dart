import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'models/dias.dart';

class FourthPage extends StatelessWidget {

final Dias dia;
  

  FourthPage(Dias this.dia);
  
  escolheDiaSemana(int dia){
    String ret;
    switch(dia){
      case 0:{
        ret = "Domingo";
      }
      break;
      
      case 1:{
        ret = "Segunda";
      }
      break;

      case 2:{
        ret = "Terça";
      }
      break;

      case 3:{
        ret = "Quarta";
      }
      break;

      case 4:{
        ret = "Quinta";
      }
      break;

      case 5:{
        ret = "Sexta";
      }
      break;

      case 6:{
        ret = "Sábado";
      }
      break;
    }
    return ret;
  }

  escolheHumor(int humor){
    String ret;
    switch(humor){  
      case 0:{
        ret = "N/A";
      } 
      break;  
      case 1:{
        ret = "😔";
      }
      break;

      case 2:{
        ret = "😶";
      }
      break;

      case 3:{
        ret = "😑";
      }
      break;

      case 4:{
        ret = "🙂";
      }
      break;

      case 5:{
        ret = "😁";
      }
      break;
      
    }
    return ret;
  }
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
            escolheDiaSemana(DateTime.parse(dia.dia).weekday) + " , " + DateTime.parse(dia.dia).day.toString(),
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
                  child:  Text(escolheHumor(dia.humor)),
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
                child: Text(dia.diario),
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




