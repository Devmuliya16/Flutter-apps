import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/components/note/note%20grid.dart';
import 'package:firebase_app/pages/auth_page.dart';
import 'package:firebase_app/widgets/floating%20action.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title});
  final String title;
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  int crossAxiscnt = 2;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logout() {
    widget.auth
        .signOut()
        .then((value) => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AuthPage(title: "Notes"))))
        .onError((error, stackTrace) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.crossAxiscnt = widget.crossAxiscnt == 2
                      ? 1
                      : widget.crossAxiscnt == 1
                          ? 3
                          : 2;
                });
                print(widget.crossAxiscnt);
              },
              icon: Icon(widget.crossAxiscnt == 2
                  ? Icons.list
                  : widget.crossAxiscnt == 1
                      ? Icons.grid_4x4
                      : Icons.grid_3x3))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .doc(widget.user!.uid)
            .collection("mynotes")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final docs = snapshot.data!.docs;

            return NotesGrid(crossAxiscnt: widget.crossAxiscnt, data: docs);
          }
        },
      ),
      floatingActionButton: FAbutton(),
    );
  }
}
