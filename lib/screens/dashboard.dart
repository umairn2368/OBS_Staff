// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        SizedBox(height: 50.0),
        Container(
          height: 40.0,
          width: 100,
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            shadowColor: Colors.yellowAccent,
            color: Colors.yellow,
            elevation: 7.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Center(
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
