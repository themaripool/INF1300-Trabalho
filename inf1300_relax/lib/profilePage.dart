import 'dart:io';

import 'package:flutter/material.dart';
import 'camera.dart';
import 'configurationPage.dart';
import 'initial_view.dart';


class ProfilePage extends StatelessWidget {

  final File imageFile;

  ProfilePage(this.imageFile);

 Widget _decideImageView(){
    if (imageFile == null){
      return Text("Nenhuma imagem selecionada");
    }  
    return Image.file(imageFile, width: 300, height:300,);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CameraPage(),
                  ),
                );
              },
              child: new Card(
                child: Text("Take profile picture"),
              )
            )
        ],
      )),
    );
  }
}
