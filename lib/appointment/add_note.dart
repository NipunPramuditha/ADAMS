import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:adams/data/firestore_service.dart';
import 'package:adams/data/model/note.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddNotePage extends StatefulWidget {
  final Note note;

  const AddNotePage({Key key, this.note}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

//appointment insertion UI
class _AddNotePageState extends State<AddNotePage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _appIDController;
  TextEditingController _doctorNameController;
  TextEditingController _healthIssueController;
  TextEditingController _hospitalController;
  TextEditingController _dateController;
  TextEditingController _timeController;
  FocusNode _doctorNameNode;
  FocusNode _healthIssueNode;
  FocusNode _hospitalNode;
  FocusNode _dateNode;
  FocusNode _timeNode;

  @override
  void initState() {
    super.initState();
    _appIDController =
        TextEditingController(text: isEditMote ? widget.note.appID : '');
    _doctorNameController =
        TextEditingController(text: isEditMote ? widget.note.doctorName : '');
    _healthIssueController =
        TextEditingController(text: isEditMote ? widget.note.healthIssue : '');
    _hospitalController =
        TextEditingController(text: isEditMote ? widget.note.hospital : '');
    _dateController =
        TextEditingController(text: isEditMote ? widget.note.date : '');
    _timeController =
        TextEditingController(text: isEditMote ? widget.note.time : '');
    _doctorNameNode = FocusNode();
    _healthIssueNode = FocusNode();
    _hospitalNode = FocusNode();
    _dateNode = FocusNode();
    _timeNode = FocusNode();
  }

  get isEditMote => widget.note != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Edit Note' : 'Add Note'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_doctorNameNode);
                },
                controller: _appIDController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Appointment ID cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Appointment Number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _doctorNameNode,
                controller: _doctorNameController,
                decoration: InputDecoration(
                  labelText: "Doctor Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _healthIssueNode,
                controller: _healthIssueController,
                decoration: InputDecoration(
                  labelText: "Health Issue",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _hospitalNode,
                controller: _hospitalController,
                decoration: InputDecoration(
                  labelText: "Hospital",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _dateNode,
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Enter Date (Ex:- 12th January 2020)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _timeNode,
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: "Enter Time (Ex:- 10.00 a.m.)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),

              //Action BUttons
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(isEditMote ? "Update" : "Save"),
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    try {
                      String docname = _doctorNameController.text.toLowerCase();
                      String appid = _appIDController.text.toLowerCase();
                      String hisue = _healthIssueController.text.toLowerCase();
                      String hosp = _hospitalController.text.toLowerCase();
                      String ddate = _dateController.text.toLowerCase();
                      String ttime = _timeController.text.toLowerCase();
                      var searchlist = new List();
                      if (docname.length > 0) {
                        for (int x = 1; x < docname.length; x++) {
                          searchlist.add(docname.substring(0, x));
                        }
                      }
                      if (hisue.length > 0) {
                        for (int x = 1; x < hisue.length; x++) {
                          searchlist.add(hisue.substring(0, x));
                        }
                      }
                      if (hosp.length > 0) {
                        for (int x = 1; x < hosp.length; x++) {
                          searchlist.add(hosp.substring(0, x));
                        }
                      }

                      if (appid.length > 0) {
                        for (int x = 1; x < appid.length; x++) {
                          searchlist.add(appid.substring(0, x));
                        }
                      }

                      if (ddate.length > 0) {
                        for (int x = 0; x < ddate.length; x++) {
                          searchlist.add(ddate.substring(0, x));
                        }
                      }

                      if (ttime.length > 0) {
                        for (int x = 0; x < ttime.length; x++) {
                          searchlist.add(ttime.substring(0, x));
                        }
                      }

                      if (isEditMote) {
                        print('edit mode , $_doctorNameController.text');
                        Note note = Note(
                          appID: _appIDController.text,
                          doctorName: _doctorNameController.text,
                          healthIssue: _healthIssueController.text,
                          hospital: _hospitalController.text,
                          date: _dateController.text,
                          time: _timeController.text,
                          searchlist: searchlist,
                          id: widget.note.id,
                        );
                        await FirestoreService().updateNote(note);
                      } else {
                        Note note = Note(
                          appID: _appIDController.text,
                          doctorName: _doctorNameController.text,
                          healthIssue: _healthIssueController.text,
                          hospital: _hospitalController.text,
                          date: _dateController.text,
                          searchlist:
                              searchlist, //FieldValue.arrayUnion([searchlist]),
                          time: _timeController.text,
                        );
                        await FirestoreService().addNote(note);
                      }
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
