import 'package:flutter/material.dart';
import 'package:fitness_app/services/Authentication.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green, //TODO Finalize Color
        title: new Text('Testing Page'),
        actions: <Widget>[
          new FlatButton(
              child: new Text(
                'Sign Out',
                style: new TextStyle(fontSize: 17.0, color: Colors.white),
              ),
              onPressed: _signOut),
        ],
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
