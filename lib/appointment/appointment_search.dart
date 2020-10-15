import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:adams/appointment/add_note.dart';
import 'package:adams/appointment/note_details.dart';
import 'package:adams/data/firestore_service.dart';
import 'package:adams/data/model/note.dart';

class AppointmentSearch extends StatefulWidget {
  @override
  _AppointmentSearchState createState() => _AppointmentSearchState();
}

class _AppointmentSearchState extends State<AppointmentSearch> {
  String text = null;
  FirestoreService fs = new FirestoreService();

  void filter(String tt) {
    setState(() {
      text = tt;
    });
  }

//appointment search view and implementation
  @override
  Widget build(BuildContext context) {
    //TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Search View'),
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Column(
        children: <Widget>[
          search(context),
          list(context),
        ],
      ))),
    );
  }

  Widget search(BuildContext context) {
    return Container(
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

  Widget searchView(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 10.0),
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Flexible(
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: 'Hospital',
                      border: OutlineInputBorder(),
                      labelText: 'Hospital'),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              new Flexible(
                child: TextField(
                  onChanged: (text) {
                    print('text is $text');
                  },
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'Doctor Name',
                      border: OutlineInputBorder(),
                      labelText: 'Doctor Name'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Flexible(
                child: TextField(
                  maxLines: 1,
                  decoration: InputDecoration(
                      hintText: 'Appointment Id',
                      border: OutlineInputBorder(),
                      labelText: 'Appointment Id'),
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              new Flexible(
                child: TextField(
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: 'Health Issue',
                      border: OutlineInputBorder(),
                      labelText: 'Health Issue'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    readOnly: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                        hintText: 'Date Time',
                        border: OutlineInputBorder(),
                        labelText: 'Date Time'),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              new Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  width: MediaQuery.of(context).size.width / 1.5,
                  // ignore: missing_required_param
                  child: OutlineButton.icon(
                      label: Text('Search'),
                      textColor: Colors.blue,
                      icon: Icon(Icons.search),
                      onPressed: () => print('object'),
                      focusColor: Colors.blue),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget list(BuildContext context) {
    return StreamBuilder(
        stream: fs.filter(text),
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
                        onPressed: () => print('dsfds'),
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
}
