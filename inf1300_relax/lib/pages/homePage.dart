
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inf1300_relax/i18n/app_localizations.dart';
import 'package:inf1300_relax/utility/utility.dart';
import 'graficoPage.dart';
import 'dayListPage.dart';
import 'imagesPage.dart';
import '../services/authentication.dart';
import '../themeStore.dart';
import 'package:provider/provider.dart';
import 'addDiaryPage.dart';
import '../pages/breathingList.dart';
import '../colors/customColors.dart';
import 'profilePage.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:screen/screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.userId, this.auth, this.logoutCallback}) : super(key: key);

  final String userId;
  final String title;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _HomePageState createState() => _HomePageState();
}

 bool isOn = false;


class _HomePageState extends State<HomePage> {

  static const platform = const MethodChannel('samples.flutter.dev/battery');

  String _username;
  String _useremail;
  int _batteryLevel;
  double _brightness;
  bool _brightnessIsChanged;
  Timer timer;

  Utility _utility = new Utility();  
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  
  initPlatformState() async {
    double brightness = await Screen.brightness;
    setState((){
      _brightness = brightness;
    });
  }

  Future<void> _getBatteryLevel() async {
    int batteryLevel;
    final int result = await platform.invokeMethod('getBatteryLevel');
    batteryLevel = result;
    setState(() {
      _batteryLevel = batteryLevel;
      if(_batteryLevel < 20 && !_brightnessIsChanged)
      {
        //Diminui brilho na metade
        Screen.setBrightness(_brightness/2);
        _brightnessIsChanged = true;
      }
      else if (_batteryLevel >= 20 && _brightnessIsChanged){
        //Volta ao valor original
        Screen.setBrightness(_brightness);
        _brightnessIsChanged = false;
      }
      
    });
  }


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
    _brightnessIsChanged = false;
    initPlatformState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _getBatteryLevel());
    widget.auth.getCurrentUser().then((user){
      setState((){
        _username = user.displayName;
        _useremail = user.email;
      });

    });
    

  }
  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){

    ThemeStore themeStore = Provider.of<ThemeStore>(context);

    DateTime date = new DateTime.now();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.0),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          // Card com o título, contendo dia e dia da semana
          Container(
            margin: EdgeInsets.only(top: 10, left: 8),
            width: 300,
            height: 50,
            child: Text(
              _utility.escolheDiaSemana(date.weekday, context) + ", ${date.day}/${date.month}",
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

              color: MyColors.grey,//Color.fromRGBO(248, 248, 255, 1),
              child: Container(
                width: 300,
                height: 150,
                decoration: new BoxDecoration(
                    color: MyColors.grey, //Theme.of(context).accentColor, 
                    borderRadius: new BorderRadius.all(Radius.circular(10))),
                child: Column(
                  children: <Widget>[
                    //Título
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 300,
                      height: 25,
                      child: Text(
                        AppLocalizations.of(context).translate('selecionarHumor'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontStyle: FontStyle.italic,
                            fontSize: 15, 
                            color: MyColors.purple),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          color: MyColors.white,
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
                  context, GraficoPage(), 'Gráfico de humor', 'iconeGrafico'),

              // Botao da ir pro historico
              _buildCardsInRow(
                  context, DayListPage(userId:widget.userId), AppLocalizations.of(context).translate('historico'), 'iconeHistorico'),
            ],
          ),

          //SECOND ROW
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            _buildCardsInRow(
                context, ImagesPage(), AppLocalizations.of(context).translate('galeriaImagens'), 'iconeGaleria'),
             _buildCardsInRow(
                context, AddDiaryPage(userId:widget.userId), AppLocalizations.of(context).translate('escreverDiario'), 'iconeDiario'),
          ]),

        ],
      )),

      // MENU LATERAL

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(AppLocalizations.of(context).translate('ola')+ " $_username. " + AppLocalizations.of(context).translate('bemvindo'), style: TextStyle(color: Colors.white)),
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

            _buildSideMenu(context, ProfilePage(), AppLocalizations.of(context).translate('perfil')),
            new Divider(),
            _buildSideMenu(context, ImagesPage(), AppLocalizations.of(context).translate('ajustes')),
            new Divider(),
            _logoutSideMenu(context, signOut, AppLocalizations.of(context).translate('sair')),
            new Divider(),
            _buildSideMenu(context, BreathingListPage(), AppLocalizations.of(context).translate('respiração')),
            new Divider(),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(AppLocalizations.of(context).translate('modoEscuro')),
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
        color: MyColors.babyBlue,//Color.fromRGBO(248, 248, 255, 1),
        child: Container(
          width: 150,
          height: 90,
          decoration: new BoxDecoration(
              color: MyColors.babyBlue, //Color.fromRGBO(248, 248, 255, 1),
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
