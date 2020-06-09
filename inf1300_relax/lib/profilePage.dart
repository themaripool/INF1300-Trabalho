import 'package:flutter/material.dart';
import 'configurationPage.dart';
import 'initial_view.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
 
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = new DateTime.now();

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(

        child: Text("Profile Page"),

      ),
       

      // MENU LATERAL

      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Olá Mariela. Bem vinda de volta!", style: TextStyle(color: Colors.white)),
              accountEmail: Text("abc123@hotmail.com", style: TextStyle(color: Colors.white),),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image:new ExactAssetImage('assets/profileBackground1.jpeg'),
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop),
                  fit: BoxFit.cover),
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: new Text("M"),

              ),
            ),

            _buildSideMenu(context, MainPage(), 'Home'),
            new Divider(),
            _buildSideMenu(context, ProfilePage(), 'Perfil'),
            new Divider(),
            _buildSideMenu(context, ConfigurationPage(), 'Ajustes'),
            new Divider()
           
           
          ],
        ),
      ),
    );
  }
}

Widget _buildSideMenu(BuildContext context, Widget page, String pageTitle) {
  return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ));
      },
      child: ListTile(
              title: Text("$pageTitle"),
              trailing:  Icon(Icons.arrow_forward),

            )
      );
}

