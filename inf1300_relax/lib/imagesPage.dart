import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  Future<List<Cat>> search(http.Client client, limit) async {
    final response = await http.get(
        "$catImageAPIURL?limit=$limit&api_key=$catApiKey");
    final body = json.decode(response.body);

    return (body as List).map((cat) => Cat.fromJSON(cat)).toList();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relax'),
      ),
      body: new FutureBuilder<List<Cat>>(
        future: search(new http.Client(), 20),
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
          child: Image.network(cats[index].url)
        );
        
      },
    );
  }
}




