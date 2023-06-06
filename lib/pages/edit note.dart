import 'package:firebase_app/components/note/edit%20note.dart';
import 'package:firebase_app/functions/crud%20funtions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key, required this.title, required this.note});
  final String title;
  var note;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
    TextEditingController titleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () async {
                if (widget.note == null)
                  create(titleController.text, noteController.text);
                else
                  update(titleController.text, noteController.text,
                      widget.note['time']);
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.save)),
          IconButton(
              onPressed: () async {
                delete(titleController.text, noteController.text,
                    widget.note['time']);
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Center(
          child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: getEditNote(
              titleController: titleController,
              noteController: noteController,
              note: widget.note),
        ),
      )),
    );
  }
}
