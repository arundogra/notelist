import 'package:flutter/material.dart';
import 'package:notelist/screens/notelist.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {

	@override
  Widget build(BuildContext context) {

    return MaterialApp(
			debugShowCheckedModeBanner: false,
	    title: 'Note List',
			theme: ThemeData(
				canvasColor: Colors.white,
				primaryColor: Colors.redAccent[100],
				accentColor: Colors.red[300],
				fontFamily: 'Georgia',
			),

			home: NoteList(),
    );
  }
}