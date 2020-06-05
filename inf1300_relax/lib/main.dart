
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'initial_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'themeStore.dart';
import 'package:provider/provider.dart';

// void main() => runApp(MyApp());

void main() {
  runApp(
    Provider(
      create: (BuildContext context) => ThemeStore(),
      child: MyApp(),
    ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ThemeStore themeStore = Provider.of<ThemeStore>(context);

    return Observer(
      name: 'theme_store_observer',
      builder: (BuildContext context) => MaterialApp(
      title: 'Flutter Demo',
      theme: themeStore.themeStore,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 5,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.white,
            Colors.white24,
          ],
        ),
        navigateAfterSeconds: MainPage(),
        loaderColor: Colors.transparent,
      ),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo2.png"),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    ],
  );
}
