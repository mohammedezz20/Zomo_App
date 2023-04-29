import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingsHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetings')
      .orderBy("createdAt", descending: true)
      .snapshots();

  void addToMeetingHistory(String meetingName, String meetingID) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetings')
          .add({
        'meetinID': meetingID,
        'meetingName': meetingName,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void addToScheduleMeetingHistory({
    required String meetingName,
    required String meetingID,
    required date,
    required time,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('scheduleMeetings')
          .add({
        'meetinID': meetingID,
        'meetingName': meetingName,
        'Date': date,
        'Time': time,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get schedulemeetingsHistory =>
      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('scheduleMeetings')
          .orderBy("Date")
          .snapshots();

  void deleteDoc(id) {
    CollectionReference docc = FirebaseFirestore.instance .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('scheduleMeetings');
    docc.doc(id).delete().then((value) {
      print('Document deleted successfully.');
    }).catchError((error) {
      print('Error deleting document: $error');
    });
  }

  Future<String> uploadImageToFirebase(image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.png';
    try {
      TaskSnapshot snapshot = await FirebaseStorage.instance
          .ref()
          .child('images/$fileName')
          .putFile(image);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e.toString());
      return "error";
    }
  }
}
