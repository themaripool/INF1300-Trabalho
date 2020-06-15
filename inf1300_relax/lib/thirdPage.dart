
import 'dart:convert';
import 'package:inf1300_relax/diasMarcados.dart';
import 'package:inf1300_relax/services/authentication.dart';

import 'fourthPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  List data;
  List entradas_diario;
  
  List<Dias> _diaList;
  Query _diaQuery;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
    
  StreamSubscription<Event> _onDiaAddedSubscription;
  StreamSubscription<Event> _onDiaChangedSubscription;

  
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
      print(_diaList.length);
      print(_diaList[0].toString());
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
  // showDiaList(){
  //       return new Container(
  //         child: ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: _diaList.length,
  //         itemBuilder: (context, index) {
  //           String diaId = _diaList[index].key;
  //           String diario = _diaList[index].diario;
  //           int humor = _diaList[index].humor;
  //           String dia = _diaList[index].dia;
  //           return new ListTile(
  //             leading: Text(diaId),
  //             title: Text(diario),
  //             subtitle: Text(dia),              
  //           );
            
  //         },
  //       )
  //       );
  //   }

  showDiaList(){
    return Scaffold(
      appBar: AppBar(
         elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.wifi),
              onPressed: () {
                addNewUser();
                addNewDia("aaaaaaaaaaaa", 7);
              }),
        ]
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
                          builder: (context) => FourthPage(data, index, entradas_diario),
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

                                Text(DateTime.parse(_diaList[index].dia).weekday.toString() + "     " + _diaList[index].humor.toString()),

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

    final items = List<String>.generate(20, (i) => "${i + 1}");
    return showDiaList();

   

    

    //IMPORTANTE NÃO DELETAR
    // return Scaffold(
    //   appBar: AppBar(
    //      elevation: 0.0,
    //     backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
    //     iconTheme: IconThemeData(color: Colors.black),
    //     actions: <Widget>[
    //       IconButton(
    //           icon: Icon(Icons.wifi),
    //           onPressed: () {
    //             addNewUser();
    //             addNewDia("bbbbbbbbbbbbbb", 2);
    //           }),
    //     ]
    //   ),
    //   body: showDiaList()
    // );


}
}