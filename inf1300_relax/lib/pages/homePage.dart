
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inf1300_relax/i18n/app_localizations.dart';
import 'package:inf1300_relax/utility/utility.dart';
import 'imagesPage.dart';
import '../services/authentication.dart';
import '../themeStore.dart';
import 'package:provider/provider.dart';
import '../pages/breathingList.dart';
import '../colors/customColors.dart';
import 'profilePage.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:screen/screen.dart';
import 'package:inf1300_relax/models/dias.dart';
import 'package:firebase_database/firebase_database.dart';

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
  Timer timerDay;
  var imageSalva;
  var result;
  String day;
  String _today = DateTime.now().toString().split(' ')[0];

  Utility _utility = new Utility();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  
  Query _diaQuery;
  List<Dias> _diaList = [];

  final FirebaseDatabase _database = FirebaseDatabase.instance;
    
  StreamSubscription<Event> _onDiaAddedSubscription;
  StreamSubscription<Event> _onDiaChangedSubscription;


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
    _batteryLevel = batteryLevel;
    if (DateTime.now().toString().split(' ')[0] != _today)
    {
      setState(() {
        _today = DateTime.now().toString().split(' ')[0];
        _diaList = [];
      });
    }
        
    if(_batteryLevel < 20 && !_brightnessIsChanged)
    {
      //Diminui brilho na metade
      setState(() {
        Screen.setBrightness(_brightness/2);
        _brightnessIsChanged = true;
      });

    }
    else if (_batteryLevel >= 20 && _brightnessIsChanged){
      //Volta ao valor original
      setState(() {
        Screen.setBrightness(_brightness);
        _brightnessIsChanged = false;
      });
    }

  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
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
  addNewDia(String diario, int humor){
      String today = DateTime.now().toString().split(' ')[0];
      if(humor > 0){
        Dias dia = new Dias(today, diario, humor);
        _database.reference().child("users").child(this.widget.userId).child(today).set(dia.toJson());
      }
    }

  updateDia(Dias dia) {
    if (dia != null) {
      _database.reference().child("users").child(this.widget.userId).child(_today).set(dia.toJson());
    }
  }

  @override
  void initState(){
    super.initState();
    _diaList = new List();
    //String today = DateTime.now().toString().split(' ')[0];
    
    _diaQuery = _database.reference().child('users').child(this.widget.userId).orderByKey().equalTo(_today);
    _onDiaAddedSubscription = _diaQuery.onChildAdded.listen(onEntryAdded);
    _onDiaChangedSubscription = _diaQuery.onChildChanged.listen(onEntryChanged);
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
    _onDiaAddedSubscription.cancel();
    _onDiaChangedSubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){

    ThemeStore themeStore = Provider.of<ThemeStore>(context);

    DateTime date = new DateTime.now();
    day = _utility.escolheDiaSemana(date.weekday, context);
    print("dia = $day");
    print("weekday = $date.weekday");
    print("weekday = $date.toString()");

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey),
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
              '$day' + ' ${date.day}/${date.month}',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontStyle: FontStyle.italic,
                  fontSize: 25),
            ),
          ),

          // Card com o medidor de humor do dia
          _cardHumor(context),

          Divider(
            color: Colors.transparent,
          ),

          _buildCardsInRow(
                context, ImagesPage(), AppLocalizations.of(context).translate('galeria'), 'iconeGaleria'),

          _buildCardsInRow(
                context, BreathingListPage(), AppLocalizations.of(context).translate('respiração'), 'iconeRespAbd'),

        ],
      )),
    	//AppLocalizations.of(context).translate('ola')
      // MENU LATERAL

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text( AppLocalizations.of(context).translate('ola')+ " $_username. "+ AppLocalizations.of(context).translate('bemvindo'),
                  style: TextStyle(color: Colors.black)),
              accountEmail: Text(
                "$_useremail",
                style: TextStyle(color: Colors.black),
              ),
              decoration: new BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/bgTeste2.jpg'), fit: BoxFit.fill ),
                //gradient: LinearGradient(colors: [MyColors.a, MyColors.a]),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: _username != null ? new Text('${_username[0].toUpperCase()}') : new Text(""),
              ),
            ),
            _buildSideMenu(
                context,
                ProfilePage(userId: widget.userId, username: _username),
                AppLocalizations.of(context).translate('perfil')),
            new Divider(),
            _logoutSideMenu(context, signOut, AppLocalizations.of(context).translate('sair')),
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


Widget _cardHumor(BuildContext context) {
  return Card(
      //shadowColor: Colors.black,
      color: MyColors.grey, //Color.fromRGBO(248, 248, 255, 1),
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
                  borderRadius: new BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildHumor('😔', 1, context),
                  _buildHumor('😶', 2, context),
                  _buildHumor('😑', 3, context),
                  _buildHumor('🙂', 4, context),
                  _buildHumor('😁', 5, context),
                ],
              ),
            ),
          ],
        ),
      )
    );
}

Widget _buildHumor(String emoji, int index, BuildContext context) {
  //print("Selected day func 1 $_selectedDay");
  return Container(
      child: SizedBox(
    width: 50, // specific value
    child: FlatButton(
      child: Text(emoji),

      color: Colors.transparent,
      // onPressed: (){
      //   print("Tocou no $index");
      // }
      onPressed: () {
        _selectedDayfunction(index, context);
      }
    ),
  ));
}


_selectedDayfunction(int index, BuildContext context) {
  if (DateTime.now().toString().split(' ')[0] != _today)
  {
    _today = DateTime.now().toString().split(' ')[0];
  }
  if(_diaList.isEmpty)
  {
    addNewDia("", index);
    _showAlertDialog(AppLocalizations.of(context).translate('hey'), AppLocalizations.of(context).translate('selecionouhumor'), context);
  }
  else{
    _diaList[0].humor = index;
    updateDia(_diaList[0]);
    _showAlertDialog(AppLocalizations.of(context).translate('hey'), AppLocalizations.of(context).translate('selecionouhumor'), context);
  }

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
        shadowColor: Colors.black,
        //color: MyColors.grey, //Color.fromRGBO(248, 248, 255, 1),

        child: Container(
          width: 200,
          height: 100,
          decoration: new BoxDecoration(
              //color: Colors.black, //Color.fromRGBO(248, 248, 255, 1),
              borderRadius: new BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Container(
                width: 10,
                color: Colors.transparent,
              ),

              Image.asset(
                "assets/$icone.png",
                width: 40,
                height: 40,
                fit: BoxFit.fill,
                color: Colors.grey,
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
              ),
              // Container(
              //   width: 5,
              //   color: Colors.transparent,
              // ),
            ],
          ),
        ),
      ));
}

void _showAlertDialog(String title, String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(title),
        content: new Text(message),
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
