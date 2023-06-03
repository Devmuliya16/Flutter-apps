import 'package:cloud_firestore/cloud_firestore.dart';

var users = FirebaseFirestore.instance
    .collection("users"); // creating tin instance of users collections
create() async {
  await users
      .doc('jhon wick 2')
      .set({'name': 'jhon wick', 'type': 'excommunicado', 'country': 'USA'})
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

read() async {}

update() async {
  await users
      .doc('jhon wick 2')
      .set({'name': 'new name'})
      .then((value) => print("user updated"))
      .catchError((error) => print("Fiaild  to update user $error"));
}

delete() async {
  await users.doc('jhon wick 2').delete();
  print("deleted doc");
}
