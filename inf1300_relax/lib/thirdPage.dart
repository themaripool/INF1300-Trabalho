
import 'dart:convert';
import 'fourthPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class ThirdPage extends StatefulWidget {
  ThirdPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {

  List data;

  Future<String> loadJsonData() async {
    
    var jsonText = await rootBundle.loadString('assets/diasMarcados.json');

    setState(() {
      data = json.decode(jsonText);
    });
    
  }

  @override
  void initState() { // called before this render on screen
    this.loadJsonData();
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

        child: Column(
          
          children:  <Widget>[

            Divider(height: 20, color: Colors.white,),

             Text(
              "Seu histórico de humor",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'RobotoMono',
                fontSize: 20,
              ),
            ),

            Divider(height: 40, color: Colors.white,),

            ListView.separated(   
                shrinkWrap: true,  
                physics: NeverScrollableScrollPhysics(), 
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index){
                    return new GestureDetector(
                      onTap: (){
                        print("clicked on card $index");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => FourthPage(data, index),
                          ),  
                        );
                      },
                      child: new Card(
                        child: new Container(
                          padding: EdgeInsets.all(10),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              
                              children: <Widget>[
                                CircleAvatar(child: Text(data[index]['intDiaSemana']),),

                                Text(data[index]['diaSemana'] + "     " + data[index]['humor']),

                                Icon(Icons.keyboard_arrow_right),
                              ],
                            )
                        )
                      )
                    );
                }, 
                separatorBuilder: (BuildContext context, int index) { 
                    return Divider(color: Colors.white,);
                },
            ),
          ],
        )
      )
    );
  }
}




