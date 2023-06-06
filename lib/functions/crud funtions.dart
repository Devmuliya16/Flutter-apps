import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// creating tin instance of collections
final users = FirebaseFirestore.instance.collection("users");
final notes = FirebaseFirestore.instance.collection("notes");
final FirebaseAuth auth = FirebaseAuth.instance;
create(String title, String note) async {
  final user = auth.currentUser;
  String uid = user!.uid;
  final String time = DateTime.now().toString();
  await notes
      .doc(uid)
      .collection('mynotes')
      .doc(time)
      .set({'title': title, 'note': note, 'time': time, 'updated': time});
}

update(String title, String note, String time) async {
  final user = auth.currentUser;
  String uid = user!.uid;

  await notes.doc(uid).collection('mynotes').doc(time).update({
    'title': title,
    'note': note,
    'time': time,
    'updated': DateTime.now().toString()
  });
}

delete(String title, String note, String timeid) async {
  final user = auth.currentUser;
  String uid = user!.uid;
  await notes.doc(uid).collection('mynotes').doc(timeid).delete();
}
