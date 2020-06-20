import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inf1300_relax/utility/utility.dart';
import 'imagesPage.dart';
import '../services/authentication.dart';
import '../themeStore.dart';
import 'package:provider/provider.dart';
import '../pages/breathingList.dart';
import '../colors/customColors.dart';
import 'profilePage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.userId, this.auth, this.logoutCallback})
      : super(key: key);

  final String userId;
  final String title;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _HomePageState createState() => _HomePageState();
}

bool isOn = false;
var _selectedDay = false;

class _HomePageState extends State<HomePage> {
  String _username;
  String _useremail;
  var imageSalva;
  var result;

  Utility _utility = new Utility();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
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
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _username = user.displayName;
        _useremail = user.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeStore themeStore = Provider.of<ThemeStore>(context);

    DateTime date = new DateTime.now();

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
              _utility.escolheDiaSemana(date.weekday) +
                  ", ${date.day}/${date.month}",
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
                context, ImagesPage(), 'Galeria de Imagens', 'iconeGaleria'),

          _buildCardsInRow(
                context, BreathingListPage(), "Respirações", 'iconeRespAbd'),

        ],
      )),

      // MENU LATERAL

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Olá $_username. Bem vindo(a) de volta!",
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
                child: new Text('${_username[0].toUpperCase()}'),
              ),
            ),
            _buildSideMenu(
                context,
                ProfilePage(userId: widget.userId, username: _username),
                'Perfil'),
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
                Switch(
                  value: isOn,
                  onChanged: (bool value) {
                    setState(() {
                      isOn = value;
                      themeStore.switchTheme();
                    });
                  },
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
                "Como você está se sentindo hoje?",
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
  print("Selected day func 1 $_selectedDay");
  return Container(
      child: SizedBox(
    width: 50, // specific value
    child: FlatButton(
      child: Text(emoji),

      color: Colors.transparent,
      // onPressed: (){
      //   print("Tocou no $index");
      // }
      onPressed: (_selectedDay == false)
          ? () => _selectedDayfunction(index, context)
          : null,
    ),
  ));
}

_selectedDayfunction(int index, BuildContext context) {
  if (!_selectedDay) {
    print("Tocou no $index");
    _selectedDay = true;
    print("Selected day $_selectedDay");
  } else {
    _showAlertDialog("Opa!", "Voce ja selecionou seu humor hoje!", context);
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
        trailing: Icon(Icons.arrow_forward),
      ));
}


Widget _logoutSideMenu(
    BuildContext context, Function signout, String pegeTitle) {
  return InkWell(
      onTap: () => signout(),
      child: ListTile(
        title: Text("$pegeTitle"),
        trailing: Icon(Icons.arrow_forward),
      ));
}

Widget _buildCardsInRow(
    BuildContext context, Widget page, String title, String icone) {
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
