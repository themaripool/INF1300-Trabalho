import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'secondPage.dart';
import 'thirdPage.dart';
import 'imagesPage.dart';
import 'services/authentication.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'themeStore.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.userId, this.auth, this.logoutCallback}) : super(key: key);

  final String userId;
  final String title;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _MainPageState createState() => _MainPageState();
}

 bool isOn = false;


class _MainPageState extends State<MainPage> {

  String _username;
  String _useremail;
  
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();


  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState(){
    super.initState();
    widget.auth.getCurrentUser().then((user){
      setState((){
        _username = user.displayName;
        _useremail = user.email;
      });

    });
    

  }


  @override
  Widget build(BuildContext context){

    ThemeStore themeStore = Provider.of<ThemeStore>(context);

    DateTime date = new DateTime.now();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          // Card com o título, contendo dia e dia da semana
          Container(
            margin: EdgeInsets.only(top: 40, left: 8),
            width: 300,
            height: 50,
            child: Text(
              "Segunda, ${date.day}/${date.month}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontStyle: FontStyle.italic,
                  fontSize: 25),
            ),
          ),

          // Card com o medidor de humor do dia
          Card(
              //shadowColor: Colors.black,

              color: Colors.blue,//Color.fromRGBO(248, 248, 255, 1),
              child: Container(
                width: 300,
                height: 150,
                decoration: new BoxDecoration(
                    color: Colors.blue, //Theme.of(context).accentColor, 
                    borderRadius: new BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: <Widget>[
                    //Título
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 300,
                      height: 25,
                      child: Text(
                        "Como você está se sentindo hoje?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontStyle: FontStyle.italic,
                            fontSize: 15),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.6),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Text('😔'),
                          ),
                          Container(
                            child: Text('😶'),
                          ),
                          Container(
                            child: Text('😑'),
                          ),
                          Container(
                            child: Text('🙂'),
                          ),
                          Container(child: Text('😁'))
                        ],
                      ),
                    ),
                  ],
                ),
              )),

          Divider(
            color: Colors.transparent,
          ),

          // Row com cards clicaveis para grafico e historico
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Botao da ir para grafico
              _buildCardsInRow(
                  context, SecongPage(), 'Gráfico de humor', 'iconeGrafico'),

              // Botao da ir pro historico
              _buildCardsInRow(
                  context, ThirdPage(userId:widget.userId), 'Histórico de humor', 'iconeHistorico'),
            ],
          ),

          //SECOND ROW
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _buildCardsInRow(
                context, ImagesPage(), 'Galeria de Imagens', 'iconeGaleria'),
          ])
        ],
      )),

      // MENU LATERAL

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Olá $_username. Bem vindo(a) de volta!", style: TextStyle(color: Colors.white)),
              accountEmail: Text("$_useremail", style: TextStyle(color: Colors.white),),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image:new ExactAssetImage('assets/profileBackground1.jpeg'),
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                  fit: BoxFit.cover),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: new Text("M"),

              ),
            ),

            _buildSideMenu(context, ImagesPage(), 'Perfil'),
            new Divider(),
            _buildSideMenu(context, ImagesPage(), 'Ajustes'),
            new Divider(),
            _logoutSideMenu(context, signOut, 'Sair'),
            new Divider(),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("Ativar dark mode"),
                ),
                
                Switch(value: isOn, onChanged: (bool value){
                  setState(() {
                    isOn = value;
                    themeStore.switchTheme();
                  });},
                  activeColor: Colors.green,
                  activeTrackColor: Colors.lightGreenAccent,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildSideMenu(BuildContext context, Widget page, String pegeTitle) {
  return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ));
      },
      child: ListTile(
              title: Text("$pegeTitle"),
              trailing:  Icon(Icons.arrow_forward),

            )
      );
}

Widget _logoutSideMenu(BuildContext context, Function signout, String pegeTitle) {
  return InkWell(
      onTap: () => signout(),
      child: ListTile(
              title: Text("$pegeTitle"),
              trailing:  Icon(Icons.arrow_forward),

            )
      );
}

Widget _buildCardsInRow( BuildContext context, Widget page, String title, String icone) {
  return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ));
      },
      child: Card(
        //shadowColor: Colors.black,
        color: Colors.blue,//Color.fromRGBO(248, 248, 255, 1),
        child: Container(
          width: 150,
          height: 90,
          decoration: new BoxDecoration(
              color: Colors.blue, //Color.fromRGBO(248, 248, 255, 1),
              borderRadius: new BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 5,
                color: Colors.transparent,
              ),
              Image.asset(
                "assets/$icone.png",
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
              Container(
                width: 10,
                color: Colors.transparent,
              ),
              Expanded(
                child: AutoSizeText(
                  '$title',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic,
                      fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ));
}
