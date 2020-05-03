import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'bigImage.dart';
import 'dart:async';
import 'dart:convert';
import 'cat.dart';

const String catApiKey = 'c940fd95-7b8b-4a62-843f-13829f56f776';

const String catImageAPIURL = 'https://api.thecatapi.com/v1/images/search';

const String catApiKeyString = 'x-api-key=$catApiKey';




class ImagesPage extends StatefulWidget {
  ImagesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  int _selectedIndex = 0;
  Future<List<Cat>> _future;
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

  Future<List<Cat>> searchCat(http.Client client, limit) async {
    final response = await http.get(
        "$catImageAPIURL?limit=$limit&api_key=$catApiKey");
    final body = json.decode(response.body);

    return (body as List).map((cat) => Cat.fromJSON(cat)).toList();
  }



  void initState(){
    _future = searchCat(new http.Client(), 20);
    
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de imagens'),
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
        actions:<Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed:(){
              setState((){_future = searchCat(new http.Client(), 20);});
              
            }
          )
          
        ] 
      ),
      body: new FutureBuilder<List<Cat>>(
        future: _future,
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          return snapshot.hasData ? new CatList(cats: snapshot.data)
          : Center(child: CircularProgressIndicator());
        }
        )


    
    );
  }
}

class CatList extends StatelessWidget {
  final List<Cat> cats;

  CatList({Key key, this.cats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GridView.builder(
      itemCount: cats.length,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return new GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                 builder: (context) => BigImage(image: cats[index].url),
                ),  
              );
            },
            child: Container(
              padding: EdgeInsets.all(3),
              child: new Image.network(
                cats[index].url, 
                fit:BoxFit.fitWidth)
              )
          )
        );
        
      },
    );
  }
}




