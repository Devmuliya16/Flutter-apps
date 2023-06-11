import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

final users = FirebaseFirestore.instance.collection("users");
final auth = FirebaseAuth.instance;

Future<bool> Signup(
    String userName, String emailAddress, String password) async {
  try {
    final response = await auth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    String uid = response.user!.uid;
    await users.doc(uid).set({'username': userName, 'email': emailAddress});
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> Login(String emailAddress, String password) async {
  try {
    final response = await auth.signInWithEmailAndPassword(
        email: emailAddress, password: password);
    print(response.user!.uid);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<String> Updatename(String name) async {
  final response = isLoggedin();
  if (response == false) return "login required";
  try {
    await users.doc(auth.currentUser!.uid).update({'username': name});
    return "Updated username";
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}

Future<String> Updateemail(String email) async {
  final response = isLoggedin();
  if (response == false) return "login required";
  try {
    await auth.currentUser!.updateEmail(email);
    await users.doc(auth.currentUser!.uid).update({'email': email});
    print(auth.currentUser!.uid);
    return "Updated email";
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}

Future<String> Updatepassword(String password) async {
  final response = isLoggedin();
  if (response == false) return "login required";
  try {
    await auth.currentUser!.updatePassword(password);
    return "Updated password";
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}

bool isLoggedin() {
  final user = auth.currentUser;
  if (user == null) {
    return false;
  } else
    return true;
}

Future<Map<String, dynamic>> getUserInfo() async {
  try {
    final user = auth.currentUser;
    DocumentSnapshot snapshot = await users.doc(user!.uid).get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    } else
      throw new Error();
  } catch (e) {
    print(e.toString());
    return {'name': "", 'email': "", 'profile': ""};
  }
}

uploadProfile() async {
  XFile? file;
  final user = auth.currentUser;
  final picker = ImagePicker();
  try {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      file = XFile(pickedFile.path);
    } else
      throw new Error();
    final storage = FirebaseStorage.instance;
    final reference = storage.ref().child('profile_pic/${user!.uid}');
    UploadTask uploadTask = reference.putFile(File(file.path).absolute);
    final url = await (await uploadTask).ref.getDownloadURL();
    await users.doc(user.uid).update({'profile': url});
  } catch (e) {
    print(e.toString());
  }
}
