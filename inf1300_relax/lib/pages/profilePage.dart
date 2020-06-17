import 'dart:io';

import 'package:flutter/material.dart';
import 'cameraPage.dart';

var result;
class ProfilePage extends StatelessWidget {

  final File imageFile;
  
  ProfilePage(this.imageFile);

  Widget _decideImageView(){
    if (result == null){
      return Text("Nenhuma imagem selecionada");
    }  
    return Container(
     height: 200.0,
     width: 200.0,
     decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: Image.file(File(result)).image, fit: BoxFit.cover),
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.0),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _decideImageView(),

          new GestureDetector(
              onTap: () {
                _navigateAndDisplaySelection(context);
              },
              child: new Card(
                child: Text("Take profile picture"),
              )
            ),
        ],
      )),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    result = await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) =>  CameraPage()),
    );
  }
}
