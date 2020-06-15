import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiaryPage extends StatefulWidget {
  DiaryPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

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
     
    );
  }
}

