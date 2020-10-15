import 'package:flutter/material.dart';
import 'package:adams/data/model/note.dart';

//appointment details retrieving UI
class NoteDetailsPage extends StatelessWidget {
  final Note note;

  const NoteDetailsPage({Key key, @required this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              note.appID,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              note.doctorName,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              note.healthIssue,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              note.hospital,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              note.date,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            Text(
              note.time,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
