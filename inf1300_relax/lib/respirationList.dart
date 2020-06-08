import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'squareRespirationPage.dart';

class RespirationListPage extends StatefulWidget {
  RespirationListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RespirationListPageState createState() => _RespirationListPageState();
}

class _RespirationListPageState extends State<RespirationListPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ],
        leading: new Container(),
      ),
      body: Center(
          child: Column(children: <Widget>[

            Text(
              "Tire um momento para se acalmar",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),

            Text(
              "Conheça nossas respirações",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: _buildCards(context, SquareRespirationPage(), 'Respiração Quadrada', 'iconeRespQuadrada'),
            )

             

            

            

      ])),
    );
  }
}

Widget _buildCards( BuildContext context, Widget page, String title, String icone) {
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
          width: 250,
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

