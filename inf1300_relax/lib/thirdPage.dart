
import 'package:inf1300_relax/services/authentication.dart';

import 'fourthPage.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'models/dias.dart';
import 'package:firebase_database/firebase_database.dart';
import 'models/user.dart';



class ThirdPage extends StatefulWidget {
  ThirdPage({Key key, this.title, this.auth, this.userId}) : super(key: key);

  final String title;
  final String userId;
  final BaseAuth auth;

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  
  List<Dias> _diaList;
  Query _diaQuery;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
    
  StreamSubscription<Event> _onDiaAddedSubscription;
  StreamSubscription<Event> _onDiaChangedSubscription;

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
  addNewUser(){
    User user = new User();
    print(widget.userId);
    _database.reference().child("users").child(this.widget.userId).push().set(user.toJson());

  }
  deleteDia(String diaId, int index) {
    _database.reference().child("users").child(this.widget.userId).child(diaId).remove().then((_) {

      setState(() {
        _diaList.removeAt(index);
      });
    });
  }

  addNewDia(String diario, int humor){
    String today = DateTime.now().toString();
    if(diario.length > 0){
      Dias dia = new Dias(today, diario, humor);
      _database.reference().child("users").child(this.widget.userId).push().set(dia.toJson());
    }
  }

  onEntryChanged(Event event) {
    var oldEntry = _diaList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _diaList[_diaList.indexOf(oldEntry)] =
          Dias.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _diaList.add(Dias.fromSnapshot(event.snapshot));
    });
  
  

  }
  @override
  void dispose() {
    _onDiaAddedSubscription.cancel();
    _onDiaChangedSubscription.cancel();
    super.dispose();
  }


  @override
  void initState() { // called before this render on screen
    super.initState();

    _diaList = new List();
    
    _diaQuery = _database.reference().child('users').child(this.widget.userId);
    _onDiaAddedSubscription = _diaQuery.onChildAdded.listen(onEntryAdded);
    _onDiaChangedSubscription = _diaQuery.onChildChanged.listen(onEntryChanged);

  }

  showDiaList(){
    return Scaffold(
      appBar: AppBar(
         elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
      ),
      body: SingleChildScrollView(

        child: Column(
          
          children:  <Widget>[

            Divider(height: 8, color: Colors.transparent,),

             Text(
              "Seu histórico de humor",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),

            Divider(height: 20, color: Colors.transparent,),

            ListView.separated(   
                shrinkWrap: true,  
                physics: NeverScrollableScrollPhysics(), 
                itemCount: _diaList == null ? 0 : _diaList.length,
                itemBuilder: (BuildContext context, int index){
                  return Dismissible(
                    key: Key(_diaList[index].key),
                    onDismissed: (left) async {
                      deleteDia(_diaList[index].key, index);
                    },
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.only(left: 270),
                        child: Icon(Icons.delete,
                            color: Colors.white,
                            
                        ),
                      ),
                    ),

                    child: new GestureDetector(
                      onTap: (){
                        print("clicked on card $index");
                        Navigator.push(
                          context,
                          //Mexer depois AAAAAAAAAAAAAAAAAAAAA
                          MaterialPageRoute(
                          builder: (context) => FourthPage(_diaList[index]),
                          ),  
                        );
                      },
                      child: new Card(
                        child: new Container(
                          padding: EdgeInsets.all(10),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                CircleAvatar(
                                  backgroundColor: Color.fromRGBO(248, 248, 255, 1), 
                                  child: Text( DateTime.parse(_diaList[index].dia).day.toString() , style: TextStyle(color: Colors.black),),
                                ),

                                Text( escolheDiaSemana(DateTime.parse(_diaList[index].dia).weekday) + "     " + escolheHumor(_diaList[index].humor)),

                                Image.asset("assets/iconeDiario.png", width: 20,height: 20,fit: BoxFit.fill,),

                                Icon(Icons.keyboard_arrow_right),
                              ],
                            )
                        )
                      )
                    )
                  );
                }, 
                separatorBuilder: (BuildContext context, int index) { 
                    return Divider(color: Colors.white,);
                },
            ),
          ],
        )
      )
    ); 
  }

  @override
  Widget build(BuildContext context) {

    return showDiaList();

   

    



}
}