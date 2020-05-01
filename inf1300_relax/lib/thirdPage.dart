
import 'dart:convert';
import 'package:inf1300_relax/diasMarcados.dart';

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
  List entradas_diario;

  Future<String> loadJsonData() async {
    
    var jsonText = await rootBundle.loadString('assets/diasMarcados.json');
    var jsonTextDiario = await rootBundle.loadString('assets/diario.json');

    setState(() {
      data = json.decode(jsonText);
      entradas_diario = json.decode(jsonTextDiario);
    });
    
  }

  @override
  void initState() { // called before this render on screen
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {

    final items = List<String>.generate(20, (i) => "${i + 1}");

   

    return Scaffold(
      appBar: AppBar(
         elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(

        child: Column(
          
          children:  <Widget>[

            Divider(height: 8, color: Colors.transparent,),

             Text(
              "Seu histórico de humor",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),

            Divider(height: 20, color: Colors.transparent,),

            ListView.separated(   
                shrinkWrap: true,  
                physics: NeverScrollableScrollPhysics(), 
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (BuildContext context, int index){
                  final item = items[index];
                  return Dismissible(
                    key: Key(data[index]["id"]),

                    onDismissed: (left) {
                      // Remove the item from the data source.
                        setState(() {
                          print(item);
                          print(data);
                          data = List.from(data);
                          print(data[index]);
                          data.removeAt(index);
                          print("Depois do dismiss");
                          print(data);
                        }
                      );

                      // Then show a snackbar.
                      // Scaffold.of(context)
                      //   .showSnackBar(SnackBar(content: Text("$item dismissed")));
                    },
                    // Show a red background as the item is swiped away.
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.only(left: 270),
                        child: Icon(Icons.delete,
                            color: Colors.white,
                            
                        ),
                      ),
                    ),

                    child: new GestureDetector(
                      onTap: (){
                        print("clicked on card $index");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => FourthPage(data, index, entradas_diario),
                          ),  
                        );
                      },
                      child: new Card(
                        child: new Container(
                          padding: EdgeInsets.all(10),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[

                                CircleAvatar(
                                  backgroundColor: Color.fromRGBO(248, 248, 255, 1), 
                                  child: Text(data[index]['intDiaSemana'], style: TextStyle(color: Colors.black),),
                                ),

                                Text(data[index]['diaSemana'] + "     " + data[index]['humor']),

                                Icon(Icons.keyboard_arrow_right),
                              ],
                            )
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




