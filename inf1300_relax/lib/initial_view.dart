import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'secondPage.dart';
import 'thirdPage.dart';
import 'imagesPage.dart';
import 'services/authentication.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.userId, this.auth, this.logoutCallback}) : super(key: key);

  final String userId;
  final String title;
  final BaseAuth auth;
  final VoidCallback logoutCallback;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
  Widget build(BuildContext context) {
    DateTime date = new DateTime.now();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Relax')
      // ),
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

              color: Color.fromRGBO(248, 248, 255, 1),
              child: Container(
                width: 300,
                height: 150,
                decoration: new BoxDecoration(
                    color: Theme.of(context)
                        .accentColor, //Color.fromRGBO(248, 248, 255, 1),
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
            color: Colors.white,
          ),

          // Row com cards clicaveis para grafico e historico
          Row(
            mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              // Botao da ir para grafico
              _buildCardsInRow(context, SecongPage(), 'Gráfico de humor', 'iconeGrafico'),

              // Botao da ir pro historico
              _buildCardsInRow(context, ThirdPage(), 'Histórico de humor', 'iconeHistorico'),
            ],
          ),

          //SECOND ROW
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[

            _buildCardsInRow(context, ImagesPage(), 'Galeria de Imagens', 'iconeGaleria'),
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.black)),
                onPressed: signOut)
            
          ])
        ],
      )),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       title: Text('Home'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       title: Text('Business'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       title: Text('School'),
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

Widget _buildCardsInRow(
  BuildContext context,
  Widget page,
  String title,
  String icone

) {
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
        color: Color.fromRGBO(248, 248, 255, 1),
        child: Container(
          width: 150,
          height: 90,
          decoration: new BoxDecoration(
              color: Color.fromRGBO(248, 248, 255, 1),
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
