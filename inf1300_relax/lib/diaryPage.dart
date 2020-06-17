import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inf1300_relax/services/authentication.dart';
import 'models/dias.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';




class DiaryPage extends StatefulWidget {
  DiaryPage({Key key, this.title, this.auth, this.userId}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final String userId;

  @override
  _DiaryPageState createState() => _DiaryPageState();

  

}

class _DiaryPageState extends State<DiaryPage> {

  final myController = TextEditingController();

  
  List<Dias> _diaList;
  Query _diaQuery;
  bool _diaJaAdicionado;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
    
  StreamSubscription<Event> _onDiaAddedSubscription;
  StreamSubscription<Event> _onDiaChangedSubscription;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    _onDiaAddedSubscription.cancel();
    _onDiaChangedSubscription.cancel();
    super.dispose();
  }

  @override
  void initState(){// called before this render on screen
    super.initState();

    _diaList = new List();
    String today = DateTime.now().toString().split(' ')[0]; 
    _diaQuery = _database.reference().child('users').child(this.widget.userId).orderByChild("dia").equalTo(today);
    _onDiaAddedSubscription = _diaQuery.onChildAdded.listen(onEntryAdded);
    _onDiaChangedSubscription = _diaQuery.onChildChanged.listen(onEntryChanged);

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

  addNewDia(String diario, int humor){
      String today = DateTime.now().toString().split(' ')[0];
      if(diario.length > 0){
        Dias dia = new Dias(today, diario, humor);
        _database.reference().child("users").child(this.widget.userId).push().set(dia.toJson());
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(

          child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 40),
          child: Text("Página de Diário",
            textAlign: TextAlign.center,            
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: 'Insira seu texto aqui'
            ),
          ),
        ),
      ]),

      ),

      floatingActionButton: FloatingActionButton(   
        onPressed: () {
          
          if(_diaList.isEmpty){
            print(myController.text);
            addNewDia(myController.text, 0);
          }
            
            // salvar texto
          
        },
        child: Icon(Icons.save),
        backgroundColor: _diaList.isEmpty ? Colors.green : Colors.grey
      ),
     
    );
  }
}

