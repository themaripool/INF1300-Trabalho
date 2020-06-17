import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cameraPage.dart';
import '../utility/profileImageUtil.dart';

//class ProfilePage extends StatelessWidget {
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //final File imageFile;

  //ProfilePage(this.imageFile);
  var result;
  var imageSalva ;
  Widget _decideImageView(String result) {
    ProfileImageUtil.getImageFromPreferences().then(
      (img) {
        setState(() {
          imageSalva = img;
        });
      }
    );
    if (imageSalva == null) {
      return Text("Nenhuma imagem selecionada");
    }
    return Container(
      height: 200.0,
      width: 200.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: Image.file(File(imageSalva)).image, fit: BoxFit.cover),
      ),
    );
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
          new GestureDetector(
              onTap: () async {
                _navigateAndDisplaySelection(context);
                //_navigationToCameraPage(context);
              },
              child: new Card(
                child: Text("Take profile picture"),
              )),
          _decideImageView(result),
        ],
      )),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    String imagem = await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CameraPage()));
    setState(() {
      this.result = imagem;
      ProfileImageUtil.saveImageToPreferences(imagem);
    });
  }
}
