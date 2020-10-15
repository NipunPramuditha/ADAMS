import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adams/data/model/note.dart';
import 'dart:async';

//firebase firestore connection for appointment searching
class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Note>> getNotes() {
    return _db.collection('appointment').snapshots().map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Note.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  //firebase search queries
  Stream<List<Note>> getFilteredNotes(String note) {
    return _db
        .collection('appointment')
        .where("doctorName", isEqualTo: "Sandun")
        .snapshots()
        .map(
          (snapshot) => snapshot.documents
              .map(
                (doc) => Note.fromMap(doc.data, doc.documentID),
              )
              .toList(),
        );
  }

  Stream<List<Note>> filter(String value) {
    print('asdasd - $value');
    //value = '258';
    if (value == null || value == '') {
      return getNotes();
    } else {
      return _db
          .collection('appointment')
          .where("searchlist", arrayContains: value)
          .snapshots()
          .map(
            (snapshot) => snapshot.documents
                .map(
                  (doc) => Note.fromMap(doc.data, doc.documentID),
                )
                .toList(),
          );
    }
  }

  Future<void> addNote(Note note) {
    return _db.collection('appointment').add(note.toMap());
  }

  Future<void> deleteNote(String id) {
    return _db.collection('appointment').document(id).delete();
  }

  Future<void> updateNote(Note note) {
    return _db
        .collection('appointment')
        .document(note.id)
        .updateData(note.toMap());
  }
}
