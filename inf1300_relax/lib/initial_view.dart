
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'secondPage.dart';
import 'thirdPage.dart';



class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

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
              margin: EdgeInsets.only(top: 35, left: 8),
              width: 300,
              height: 50,
              child: 
              Text("Segunda, ${date.day}/${date.month}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontStyle: FontStyle.italic,
                  fontSize: 25
                ),
              ),
            ),

            // Card com o medidor de humor do dia
            Card(
              shadowColor: Colors.black,
              color: Color.fromRGBO(240, 248, 255, 1),
              child:Container(
                  width: 300,
                  height: 150,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(240, 248, 255, 1),
                    borderRadius: new BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.only(top: 8),
                        color: Colors.blueGrey,
                        width: 250,
                        height: 50,


                      ),






                    ],
                  ),
              )
            ),

            // Botão temporário para ir pro grafico
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => SecongPage(),
                  ),  
                );
              },
              child: const Text(
                'Ir nivel 1 de push',
                style: TextStyle(fontSize: 20)
              ),
            ),

            Divider(color: Colors.white,),

            // Row com cards clicaveis para grafico e historico
            Row(
              children: <Widget>[

                // Botao da ir para grafico

                GestureDetector(

                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SecongPage(),));
                  },
                  
                  child: Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(240, 248, 255, 1),
                    child:
                      Container(
                        width: 150,
                        height: 90,
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(240, 248, 255, 1),
                          borderRadius: new BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            Container(
                              width: 5,
                              color: Colors.transparent,
                            ),

                            Image.asset("assets/iconeGrafico.png",width: 40,height: 40,fit: BoxFit.fill,),

                            Container(
                              width: 5,
                              color: Colors.transparent,
                            ),

                            Expanded(child:
                              AutoSizeText(
                                'Gráfico de humor',
                                style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ) 
                          ],
                        ),
                      ),
                  )
                ),

                // Botao da ir pro historico
                 GestureDetector(

                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) => ThirdPage(),));
                  },
                  
                  child: Card(
                    shadowColor: Colors.black,
                    color: Color.fromRGBO(248, 248, 255, 1),
                    child:
                      Container(
                        width: 150,
                        height: 90,
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(248, 248, 255, 1),
                          borderRadius: new BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                            Container(
                              width: 5,
                              color: Colors.transparent,
                            ),

                            Image.asset("assets/iconeHistorico.png", width: 40,height: 40,fit: BoxFit.fill,),

                            Container(
                              width: 5,
                              color: Colors.transparent,
                            ),

                            Expanded(child:
                              AutoSizeText(
                                'Histórico de humor',
                                style: TextStyle(fontFamily: 'RobotoMono', fontSize: 15),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ) 
                          ],
                        ),
                      ),
                  )
                )

              ],
            )
           
           
          ],

        )
      ),


      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}




