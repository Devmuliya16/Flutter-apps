import 'package:firebase_app/components/note/edit%20note.dart';
import 'package:firebase_app/functions/crud%20funtions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/dropdown.dart';

class EditNote extends StatefulWidget {
  EditNote({super.key, required this.title, required this.note});
  final String title;
  var note;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  String? selectedTag;
  final auth = FirebaseAuth.instance;
  List<String> tags = [];
  @override
  void initState() {
    initializeTags();
    if (widget.note != null) {
      if (tags.contains(widget.note)) {
        this.selectedTag = widget.note['tag'];
      } else
        this.selectedTag = null;
    } else
      this.selectedTag = null;
  }

  Future<void> initializeTags() async {
    List<String> fetchedTags = await fetchTags();
    setState(() {
      tags = fetchedTags;
    });
  }

  selectTag(String tag) {
    setState(() {
      selectedTag = tag;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController noteController = TextEditingController();
    TextEditingController titleController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(widget.title),
        actions: [
          DropdownComp(
            tags: tags,
            selectedTag: selectedTag,
            selectTag: this.selectTag,
          ),
          IconButton(
              onPressed: () async {
                if (widget.note == null)
                  create(titleController.text, noteController.text,
                      selectedTag ?? "");
                else
                  update(titleController.text, noteController.text,
                      widget.note['time'], selectedTag ?? "");
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.save)),
          IconButton(
              onPressed: () async {
                delete(titleController.text, noteController.text,
                    widget.note['time']);
                Navigator.pop(context, true);
              },
              icon: Icon(Icons.delete)),
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
