import 'package:flutter/material.dart';

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
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: Center(

        child: Text("Configuration Page"),

      ),
    );
  }
}


