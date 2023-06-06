import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final users = FirebaseFirestore.instance.collection("users");
final auth = FirebaseAuth.instance;

class Auth {
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<bool> Login(String emailAddress, String password) async {
    try {
      final response = await auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      print(response.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  bool isLoggedin() {
    final user = auth.currentUser;
    print(auth);
    print(user);

    if (user == null) {
      return false;
    } else
      return true;
  }
}
