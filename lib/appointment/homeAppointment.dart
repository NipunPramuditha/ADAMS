import 'package:flutter/material.dart';
import 'package:adams/data/firestore_service.dart';
import 'package:adams/data/model/note.dart';
import 'package:adams/appointment/add_note.dart';
import 'package:adams/appointment/note_details.dart';

class HomeAppointment extends StatefulWidget {
  @override
  _HomeAppointmentState createState() => _HomeAppointmentState();
}

//appointment home view
class _HomeAppointmentState extends State<HomeAppointment> {
  String text = null;
  void filter(String tt) {
    setState(() {
      text = tt.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0, right: 5.0),
              child: search(context),
            ),
            list(context),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNotePage()));
        },
      ),
    );
  }

  Widget search(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: TextField(
        onChanged: (t) {
          filter(t);
        },
        maxLines: 1,
        decoration: InputDecoration(
            hintText: 'Enter text here',
            border: OutlineInputBorder(),
            labelText: 'Search here'),
      ),
    );
  }

  //appointment update implementation
  Widget list(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreService().filter(text),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Note note = snapshot.data[index];
              return Container(
                child: ListTile(
                  title: Text(note.appID != null ? note.appID : ''),
                  subtitle:
                      Text(note.doctorName != null ? note.doctorName : ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        color: Colors.blue,
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddNotePage(note: note),
                            )),
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteNote(context, note.id),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NoteDetailsPage(
                        note: note,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  void _deleteNote(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteNote(id);
      } catch (e) {
        print(e);
      }
    }
  }

  //appointment delete window
  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("Are you sure you want to delete?"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("Delete"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
