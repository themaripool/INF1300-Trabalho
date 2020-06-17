import 'dart:io';
import 'package:flutter/material.dart';
import '../colors/customColors.dart';
import '../pages/cameraPage.dart';
import '../utility/profileImageUtil.dart';

//class ProfilePage extends StatelessWidget {
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var result;
  var imageSalva;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFFFFFFFF).withOpacity(0.0),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: <Widget>[
          _viewBackground(),
          _listViewBuilder(),
        ],
      ),
    );
  }

  Widget _viewBackground() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [MyColors.purple, MyColors.purple]),
        // colors: [Colors.indigo.shade300, Colors.indigo.shade500]),
      ),
    );
  }

  Widget _listViewBuilder() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: _mainListBuilder,
    );
  }

  Widget _mainListBuilder(BuildContext context, int index) {
    if (index == 0) return _buildHeader(context);
    //if (index == 1) return _previousBody();
  }

  Widget _previousBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        new GestureDetector(
            onTap: () async {
              _navigateAndDisplaySelection(context);
              //_navigationToCameraPage(context);
            },
            child: new Card(
              child: Text("Escolher foto de perfil"),
            )),
        _decideImageView(result),
      ],
    );
  }

  Widget _decideImageView(String result) {
    ProfileImageUtil.getImageFromPreferences().then((img) {
      setState(() {
        imageSalva = img;
      });
    });
    //
    return Container(
      height: 5.0,
      width: 5.0,
      color: Colors.transparent,
    );
  }

  //Widgets Header

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      height: 240.0,
      child: Stack(
        children: <Widget>[
          _backgroundHeader(),
          _profileCircularImage()
        ],
      ),
    );
  }

  Widget _columnOnHeader() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Text(
          "Seu nome aqui!",
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(
          height: 5.0,
        ),
        _previousBody(),
        SizedBox(
          height: 16.0,
        ),
        Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        )
      ],
    );
  }

  Widget _backgroundHeader() {
    return Container(
      padding:
          EdgeInsets.only(top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
      child: Material(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5.0,
        color: Colors.white,
        child: _columnOnHeader(),
      ),
    );
  }

  Widget _profileCircularImage(){
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: (imageSalva != null)
                        ? Image.file(File(imageSalva)).image
                        : AssetImage("assets/placeholder.png")),
              ),
            ],
          );
  }

  
//Navegação para tela de camera
  _navigateAndDisplaySelection(BuildContext context) async {
    String imagem = await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CameraPage()));
    setState(() {
      this.result = imagem;
      ProfileImageUtil.saveImageToPreferences(imagem);
    });
  }
}
