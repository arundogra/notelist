import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteDetailsState();
  }
}

class NoteDetailsState extends State<NoteDetails> {
  static var _priorties = ['High', 'Low'];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
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

                value: 'Low',

                onChanged:(valueSelectedByUser) {
                  setState(() {
                    debugPrint('TEST $valueSelectedByUser');
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
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Save button clicked');
                        });
                      },
                    ),
                  ),

                  Container(width: 5.0,),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('Delete button clicked');
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
    );
  }
}
