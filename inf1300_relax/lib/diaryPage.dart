import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'imagesPage.dart';
import 'themeStore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

bool isOn = false;

class _DiaryPageState extends State<DiaryPage> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeStore themeStore = Provider.of<ThemeStore>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(

          child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Título'),
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

          print(myController.text);
          // salvar texto
          
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.green,
      ),
     
       
      // MENU LATERAL

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Olá Mariela. Bem vinda de volta!",
                  style: TextStyle(color: Colors.white)),
              accountEmail: Text(
                "abc123@hotmail.com",
                style: TextStyle(color: Colors.white),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                    image:
                        new ExactAssetImage('assets/profileBackground1.jpeg'),
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
            _buildSideMenu(context, ImagesPage(), 'Sair'),
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
        //shadowColor: Colors.black,
        color: Colors.blue, //Color.fromRGBO(248, 248, 255, 1),
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
