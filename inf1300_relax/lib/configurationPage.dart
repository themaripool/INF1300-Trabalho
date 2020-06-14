import 'package:flutter/material.dart';
import 'profilePage.dart';
import 'initial_view.dart';

class ConfigurationPage extends StatefulWidget {
  ConfigurationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.0),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(

        child: Text("Configuration Page"),

      ),
    );
  }
}


