import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inf1300_relax/services/authentication.dart';
import '../models/dias.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:inf1300_relax/i18n/app_localizations.dart';



class AddDiaryPage extends StatefulWidget {
  AddDiaryPage({Key key, this.title, this.auth, this.userId}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final String userId;

  @override
  _AddDiaryPageState createState() => _AddDiaryPageState();

  

}

class _AddDiaryPageState extends State<AddDiaryPage> {

  final myController = TextEditingController();

  
  List<Dias> _diaList;
  Query _diaQuery;

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

  updateDia(Dias dia) {
    if (dia != null) {
      _database.reference().child("users").child(this.widget.userId).child(dia.key).set(dia.toJson());
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
          child: 
             Text(
              AppLocalizations.of(context).translate('escreverDiarioPage'),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),          
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            enabled: ((_diaList.isEmpty) || (_diaList[0].humor != 0 && _diaList[0].diario.isEmpty)) ? true : false,
            controller: myController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: AppLocalizations.of(context).translate('escreverDiarioPageInsert')
            ),
          ),
        ),
      ]),

      ),

      floatingActionButton: FloatingActionButton(   
        onPressed: () {
          
          if(_diaList.isEmpty){
            //print(myController.text);
            addNewDia(myController.text, 0);
            // salvar texto
          }
          else if(_diaList[0].humor != 0 && _diaList[0].diario.isEmpty){
            _diaList[0].diario = myController.text;
            updateDia(_diaList[0]);
          }
          else{
            //JÁ FOI ADICIONADO DIÁRIO NESSE DIA
            _showAlertDialog(AppLocalizations.of(context).translate('opa'), AppLocalizations.of(context).translate('jaescreveu'), context);
          }
            
           
          
        },
        child: Icon(Icons.save),
        //verifica se tem entrada no dia de hoje ou se foi adicionado pelo menu de humor deixando o diário vazio.
        backgroundColor: ((_diaList.isEmpty) || (_diaList[0].humor != 0 && _diaList[0].diario.isEmpty)) ? Colors.green : Colors.grey
      ),
     
    );
  }
}

void _showAlertDialog(String title, String message, BuildContext context) {
   showDialog(
     context: context,
     builder: (BuildContext context) {
       // return object of type Dialog
       return AlertDialog(
         title: new Text(title),
         content:
             new Text(message),
         actions: <Widget>[
           new FlatButton(
             child: new Text("ok"),
             onPressed: () {
               Navigator.of(context).pop();
             },
           ),
         ],
       );
     },
   );
 }
