import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class CameraPage extends StatefulWidget {
  CameraPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  File imageFile;

  _openGalery() async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera() async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Escolher imagem de:"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(
                child: Text("Galeria"),
                onTap: (){
                  _openGalery();
                },
              ),

              Padding(padding: EdgeInsets.all(8),),

              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera();
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _decideImageView(){
    if (imageFile == null){
      return Text("Nenhuma imagem selecionada");
    }
    return Image.file(imageFile, width: 300, height:300,);
  }

  Widget _saveProfileImage(){
    if (imageFile != null){
      return RaisedButton(
        onPressed: (){
          Navigator.pop(context, imageFile.uri.path);
        }, 
        child: Text("Salvar imagem"),
      );
    } else {
      return RaisedButton(
        onPressed: (){
          print("Nops");
        }, 
        child: Text("Salvar imagem"),
        
      );

    }
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

            RaisedButton(
              onPressed: (){
                _showChoiceDialog(context);
              }, 
              child: Text("Selecionar imagem"),),
            _saveProfileImage()
          ],
        )
      ),
    );
  }
}
