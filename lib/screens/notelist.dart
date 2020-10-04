import 'package:flutter/material.dart';
import 'package:notelist/screens/notedetails.dart';

//Notelist StateFulWidget
class NoteList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21.0),
            side: BorderSide(color: Colors.white, width: 6.0)
        ),
        onPressed: () {
          debugPrint('Test Floating Butoon');
          navigatePages('Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  //Get Notelist
  ListView getNoteListView () {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context , int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading:  CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(
                  Icons.keyboard_arrow_right
                ),
              ),
              title: Text('Title'),
              subtitle: Text('Date'),
              trailing: Icon(Icons.delete, color: Colors.grey,),

              onTap: (){
                debugPrint('test');
                navigatePages('Edit Note');
              },
            ),
          );
        },
    );
  }

  void navigatePages (String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(title);
    }));
  }

}