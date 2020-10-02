import 'package:flutter/material.dart';
// import 'package:notelist/screens/notelist.dart';
import 'package:notelist/screens/notedetails.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightGreenAccent[800],
        accentColor: Colors.grey[600],
        fontFamily: 'Georgia',
        ),

      debugShowCheckedModeBanner: false,
      title: 'Note List',
      home: NoteDetails(),
    );
  }
}