import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:notelist/utils/database_helper.dart';
import 'package:notelist/models/note.dart';



class NoteDetail extends StatefulWidget {

  final String appBarTitle;
  final Note note;
  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
   var _priorties = ['High', 'Low'];

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Note note;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteDetailState(this.note, this.appBarTitle);
  @override
  Widget build(BuildContext context) {

    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        homePage();
      },
      child: Scaffold(

      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(icon: Icon(
            Icons.arrow_back),
            onPressed: () {
              homePage();
            }
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 18.0, right: 10.0, left: 10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: DropdownButton(
                items: _priorties.map((String dropDownStringItem){
                  return  DropdownMenuItem<String> (
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                 }).toList(),

                value: getPriorityAsString(note.priority),

                onChanged:(valueSelectedByUser) {
                  setState(() {
                    debugPrint('TEST $valueSelectedByUser');
                    updatePriorityAsInt(valueSelectedByUser);
                  });
                }
              ),
            ),

            //Second Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child:  TextField(
                controller: titleController,
                onChanged: (value) {
                  debugPrint('Test');
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),

            //Third Element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child:  TextField(
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint('Description');
                  updateDescription();
                },
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0, left: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.redAccent[100],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white, width: 3.0)
                      ),
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,

                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Save button clicked');
                          _save();
                        });
                      },
                    ),
                  ),

                  Container(width: 100.0,),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.redAccent[100],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white, width: 3.0)
                      ),
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Delete button clicked');
                          _delete();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ));
  }

  void homePage () {
    Navigator.pop(context, true);
  }

  // Convert the String priority in the form of integer before saving it to Database
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }


  // Convert int priority to String priority and display it to user in DropDown
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorties[0];  // 'High'
        break;
      case 2:
        priority = _priorties[1];  // 'Low'
        break;
    }
    return priority;
  }

  //Update the title
  void updateTitle() {
    note.title = titleController.text;
  }

  //Update
  void updateDescription() {
    note.description = descriptionController.text;
  }

  //Save
  void _save() async {

    homePage();

    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;

    if(note.id != null) {
      result = await helper.updateNote(note);

    } else {
      result = await helper.insertNote(note);

    }
    if(result != 0) {
      _showAlertDialog('Status', 'Note Saved SUCCESSFULLY');
    } else { //Fail
      _showAlertDialog('Status', 'PROBLEM Saving Note');
    }
  }

   void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
    );
    showDialog(
     context: context,
     builder: (_) => alertDialog,
     );
   }

   //Delete
  void _delete() async {
    homePage();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }


}
