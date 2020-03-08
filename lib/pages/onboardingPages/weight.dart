import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Weight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          weight(context),
          //nextButton(context),
        ],
      ),
    );
  }

  Widget weight(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.yellow,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'What is your weight?',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.only(right: 16, bottom: 16),
                  child: FloatingActionButton(
                    backgroundColor: Colors.deepOrange,
                    heroTag: 'nextButton',
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/sixth',
                      );
                    },
                    shape: CircleBorder(),
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
