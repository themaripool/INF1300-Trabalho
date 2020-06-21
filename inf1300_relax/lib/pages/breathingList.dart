import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'BreathingPage.dart';
import 'package:inf1300_relax/i18n/app_localizations.dart';

class BreathingListPage extends StatefulWidget {
  BreathingListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BreathingListPageState createState() => _BreathingListPageState();
}

class _BreathingListPageState extends State<BreathingListPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey),
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
              AppLocalizations.of(context).translate('acalmar'),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),

            Text(
              AppLocalizations.of(context).translate('pratiquerespiracao'),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: _buildCards(context, BreathingPage(0), AppLocalizations.of(context).translate('respiracaoquadrada'), 'iconeRespQuadrada'),
            ), 

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _buildCards(context, BreathingPage(1), AppLocalizations.of(context).translate('respiracaoabdominal'), 'iconeRespAbd'),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _buildCards(context, BreathingPage(2), AppLocalizations.of(context).translate('respiracaoalta'), 'iconeRespAlta'),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: _buildCards(context, BreathingPage(3), AppLocalizations.of(context).translate('respiracaocompleta'), 'iconeRespComp'),
            ),  
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
        //color: Colors.blue,//Color.fromRGBO(248, 248, 255, 1),
        child: Container(
          width: 250,
          height: 90,
          decoration: new BoxDecoration(
              //color: Colors.blue, //Color.fromRGBO(248, 248, 255, 1),
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
              )
            ],
          ),
        ),
      ));
}

