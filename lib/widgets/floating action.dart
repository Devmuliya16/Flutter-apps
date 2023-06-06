import 'package:firebase_app/pages/edit%20note.dart';
import 'package:flutter/material.dart';

class FAbutton extends StatelessWidget {
  const FAbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditNote(
                      title: "New Note",
                      note: null,
                    )));
      },
      child: Icon(Icons.add),
    );
  }
}
