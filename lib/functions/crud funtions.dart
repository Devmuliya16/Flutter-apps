import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// creating tin instance of collections
final users = FirebaseFirestore.instance.collection("users");
final notes = FirebaseFirestore.instance.collection("notes");
final FirebaseAuth auth = FirebaseAuth.instance;

create(String title, String note, String tag) async {
  final user = auth.currentUser;
  String uid = user!.uid;
  final String time = DateTime.now().toString();
  await notes.doc(uid).collection('mynotes').doc(time).set({
    'title': title,
    'note': note,
    'tag': tag,
    'time': time,
    'updated': time
  });
}

update(String title, String note, String time, String tag) async {
  final user = auth.currentUser;
  String uid = user!.uid;

  await notes.doc(uid).collection('mynotes').doc(time).update({
    'title': title,
    'note': note,
    'tag': tag,
    'time': time,
    'updated': DateTime.now().toString()
  });
}

delete(String title, String note, String timeid) async {
  final user = auth.currentUser;
  String uid = user!.uid;
  await notes.doc(uid).collection('mynotes').doc(timeid).delete();
}

addtag(String name, String color) async {
  final user = auth.currentUser;
  String uid = user!.uid;
  final QuerySnapshot querySnapshot = await notes
      .doc(uid)
      .collection('mytags')
      .where('name', isEqualTo: name)
      .get();

  if (querySnapshot.docs.isEmpty == true) {
    await notes
        .doc(uid)
        .collection('mytags')
        .add({'name': name, 'color': color});
    print("added tag");
  } else {
    print("already exists");
  }
}

fetchTags() async {
  final user = auth.currentUser;
  String uid = user!.uid;
  try {
    QuerySnapshot querySnapshot =
        await notes.doc(uid).collection('mytags').get();

    List<String> fetchedTags = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('name') && data['name'] != null) {
        return data['name'] as String;
      } else {
        return '';
      }
    }).toList();
    return fetchedTags;
  } catch (e) {
    print('Error fetching tags: $e');
    return [];
  }
}

Stream<QuerySnapshot<Map<String, dynamic>>>? getNotes(int opt, String str) {
  final user = auth.currentUser;
  switch (opt) {
    case 0:
      return notes.doc(user!.uid).collection("mynotes").snapshots();

    default:
      return notes
          .doc(user!.uid)
          .collection("mynotes")
          .where('tag', isEqualTo: str)
          .snapshots();
  }
}

deleteTag(String tagname) async {
  final user = auth.currentUser;
  await notes.doc(user!.uid).collection('mytags').doc(tagname).delete();
}

addTag(String tagname) async {
  final user = auth.currentUser;
  await notes
      .doc(user!.uid)
      .collection('mytags')
      .doc(tagname)
      .set({'name': tagname});
}
