import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../colors/customColors.dart';
import '../pages/cameraPage.dart';
import '../utility/profileImageUtil.dart';
import 'dayListPage.dart';
import 'addDiaryPage.dart';
import 'package:inf1300_relax/i18n/app_localizations.dart';

//class ProfilePage extends StatelessWidget {
class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title, this.userId, this.username})
      : super(key: key);

  final String title;
  final String userId;
  final String username;

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
        backgroundColor: Colors.transparent,//const Color(0xFFFFFFFF).withOpacity(0.0),
        iconTheme: IconThemeData(color: Colors.grey),
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
        image: DecorationImage(image: AssetImage('assets/bgTeste2.jpg'), fit: BoxFit.fill ),
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
    if (index == 1) return _buildButtons();
  }

  Widget _buildButtons() {
    return Padding(
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [
            _buildCardsInRow(context, DayListPage(userId: widget.userId),
                AppLocalizations.of(context).translate('historico'), 'iconeHistorico'),
            _buildCardsInRow(context, AddDiaryPage(userId: widget.userId),
                AppLocalizations.of(context).translate('escreverDiario'), 'iconeDiario'),
          ],
        ));
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
              color: Colors.white,
              child: Container(
                height: 25,
                width: 150,
                child: Padding(padding: EdgeInsets.only(top: 5),
                  child:Text(AppLocalizations.of(context).translate('escolherfoto'), textAlign: TextAlign.center,),
                )
  
              )
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
          _profileCircularImage(),
        ],
      ),
    );
  }

  Widget _columnOnHeader() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 90.0,
        ),
        Text(
          widget.username,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontStyle: FontStyle.italic,
            fontSize: 15,
            color: MyColors.purple
          )
        ),
        SizedBox(
          height: 5.0,
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _previousBody(),
            ],
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
        color: MyColors.grey,
        child: _columnOnHeader(),
      ),
    );
  }

  Widget _profileCircularImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Material(
          elevation: 5.0,
          shape: CircleBorder(),
          child: CircleAvatar(
              radius: 60.0,
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

Widget _buildCardsInRow(
    BuildContext context, Widget page, String title, String icone) {
  return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ));
      },
      child: Card(
        //shadowColor: Colors.black,
        //color: MyColors.babyBlue, //Color.fromRGBO(248, 248, 255, 1),
        child: Container(
          width: 150,
          height: 90,
          decoration: new BoxDecoration(
              //color: MyColors.babyBlue, //Color.fromRGBO(248, 248, 255, 1),
              borderRadius: new BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 5,
                color: Colors.transparent,
              ),
              Image.asset(
                "assets/$icone.png",
                width: 40,
                height: 40,
                fit: BoxFit.fill,
                color: Colors.grey,
              ),
              Container(
                width: 10,
                color: Colors.transparent,
              ),
              Expanded(
                child: AutoSizeText(
                  '$title',
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic,
                      fontSize: 15),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ));
}
