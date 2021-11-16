// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

   body: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
       Container(
         child: Stack(
           children: <Widget>[
                   Container(
                       padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                       child: Text(
                         'Search',
                         style: TextStyle(
                             fontSize: 80.0, fontWeight: FontWeight.bold),
                       )),
                 ])),
         ]),
    );
  }
}
