import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:adams/appointment/note_details.dart';
import 'package:adams/data/firestore_service.dart';
import 'appointment/add_note.dart';
import 'data/model/note.dart';

class GeneratePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

class GeneratePageState extends State<GeneratePage> {
  // already generated qr code when the page opens
  String qrData = "https://github.com/neon97";
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
        title: Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(
                //plce where the QR Image will be shown
                data: qrData,
              ),
              SizedBox(
                height: 40.0,
              ),
//              Text(
//                "New QR Link Generator",
//                style: TextStyle(fontSize: 20.0),
//              ),
              // TextField(
              //   controller: qrdataFeed,
              //   decoration: InputDecoration(
              //     hintText: "Input your link or data",
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: FlatButton(
                  padding: EdgeInsets.all(15.0),
                  onPressed: () async {
                    if (qrdataFeed.text.isEmpty) {
                      //a validation for the textfield
                      setState(() {
                        qrData = "";
                      });
                    } else {
                      setState(() {
                        qrData = qrdataFeed.text;
                      });
                    }
                  },
                  child: Text(
                    "Generate QR",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue, width: 3.0),
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),

              SingleChildScrollView(
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
            ],
          ),
        ),
      ),
    );
  }

  final qrdataFeed = TextEditingController();

  //search an appointment to generate QR code
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
