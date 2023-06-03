import 'package:firebase_app/components/crud.dart';
import 'package:firebase_app/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../components/users  list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.title});
  final auth = FirebaseAuth.instance;
  final String title;

  @override
  Widget build(BuildContext context) {
    void Logout() {
      auth
          .signOut()
          .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthPage(title: "Notes"))))
          .onError((error, stackTrace) => print(error));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          IconButton(
              onPressed: () {
                Logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Container(
        child: Column(
          children: [
            getCrud(),
            SizedBox(height: 30),
            getList(),
          ],
        ),
      )),
    );
  }
}
