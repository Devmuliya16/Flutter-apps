import 'package:firebase_app/components/drawer/drawer%20component.dart';
import 'package:firebase_app/components/note/note%20grid.dart';
import 'package:firebase_app/functions/crud%20funtions.dart';
import 'package:firebase_app/widgets/floating%20action.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'edit note.dart';

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
  String str = '';
  int opt = 0;

  setOptions(int opt, String str) {
    setState(() {
      this.str = str;
      this.opt = opt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComp(auth: widget.auth, setOpt: setOptions, str: this.str),
      appBar: AppBar(
        title: Text(opt == 0 ? widget.title : str),
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
        stream: getNotes(opt, str),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("no notes available"));
          } else {
            final docs = snapshot.data!.docs;
            return NotesGrid(crossAxiscnt: widget.crossAxiscnt, data: docs);
          }
        },
      ),
      floatingActionButton: FAbutton(fun: getEdit, icon: Icons.add),
    );
  }

  void getEdit() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditNote(
                  title: "New Note",
                  note: null,
                )));
  }
}
