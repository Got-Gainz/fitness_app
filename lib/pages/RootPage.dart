import 'package:flutter/material.dart';
import 'package:fitness_app/pages/LoginSignupPage.dart';
import 'package:fitness_app/backend/Authentication.dart';
import 'package:fitness_app/pages/HomePage.dart'; //TODO Add homepage here and remove testing homepage

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = '';

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then(
      (user) {
        setState(
          () {
            if (user != null) {
              _userId = user?.uid;
            }
            authStatus = user?.uid == null
                ? AuthStatus.NOT_LOGGED_IN
                : AuthStatus.LOGGED_IN;
          },
        );
      },
    );
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then(
      (user) {
        setState(
          () {
            _userId = user.uid.toString();
          },
        );
      },
    );
    setState(
      () {
        authStatus = AuthStatus.LOGGED_IN;
      },
    );
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
        return LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return HomePage(
              //userId: _userId,
              //auth: widget.auth,
              //logoutCallback: loginCallback,
              );
        } else {
          return buildWaitingScreen();
        }
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
