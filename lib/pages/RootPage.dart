import 'package:flutter/material.dart';
import 'package:fitness_app/pages/LoginSignupPage.dart';
import 'package:fitness_app/backend/Authentication.dart';
import 'package:fitness_app/pages/HomePage.dart'; //TODO Add homepage here and remove testing homepage

enum AuthStatus {
  NOT_DETERMINED,
  LOGGED_OUT,
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
                ? AuthStatus.LOGGED_OUT
                : AuthStatus.LOGGED_IN;
          },
        );
      },
    );
  }

  void _loginCallback() {
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

  void _logoutCallback() {
    setState(
      () {
        authStatus = AuthStatus.LOGGED_OUT;
        _userId = "";
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
      case AuthStatus.LOGGED_OUT:
        return LoginSignupPage(
          auth: widget.auth,
          loginCallback: _loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: _logoutCallback,
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
