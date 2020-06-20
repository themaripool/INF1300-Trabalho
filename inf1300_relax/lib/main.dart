import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'pages/homePage.dart';
import 'pages/login_page.dart';
import 'services/authentication.dart';


import 'package:flutter_mobx/flutter_mobx.dart';
import 'themeStore.dart';
import 'package:provider/provider.dart';
import 'i18n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



// void main() => runApp(MyApp());

void main() {
  runApp(
    Provider(
      create: (BuildContext context) => ThemeStore(),
      child: MyApp(),
    ));
}

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ThemeStore themeStore = Provider.of<ThemeStore>(context);

    return Observer(
      name: 'theme_store_observer',
      builder: (BuildContext context) => MaterialApp(
      supportedLocales: [
        Locale('pt', 'BR'),
        Locale('en', 'US')
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      title: 'Flutter Demo',
      theme: themeStore.themeStore,
      home: MyHomePage(title: 'Flutter Demo Home Page', auth: new Auth()),
    )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.auth}) : super(key: key);
  final String title;
  final BaseAuth auth;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }
  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
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
          navigateAfterSeconds: HomePage(),
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
}