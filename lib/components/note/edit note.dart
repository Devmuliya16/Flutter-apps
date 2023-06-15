import 'package:flutter/material.dart';

class getEditNote extends StatefulWidget {
  const getEditNote({
    super.key,
    required this.titleController,
    required this.noteController,
    required this.note,
  });

  final TextEditingController titleController;
  final TextEditingController noteController;
  final note;

  @override
  State<getEditNote> createState() => _getEditNoteState();
}

class _getEditNoteState extends State<getEditNote> {
  @override
  Widget build(BuildContext context) {
    widget.titleController.text =
        this.widget.note != null ? this.widget.note['title'] : "";
    widget.noteController.text =
        this.widget.note != null ? this.widget.note['note'] : "";
    return Column(
      children: [
        TextField(
          controller: widget.titleController,
          maxLines: 1,
          autocorrect: true,
          style: TextStyle(fontSize: 30),
          decoration: InputDecoration(hintText: 'Note title'),
        ),
        SizedBox(height: 20),
        Expanded(
          child: TextField(
            controller: widget.noteController,
            maxLines: null,
            expands: true,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
              hintText: 'Start typing...',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  selectTag(String tag) {
    setState(() {});
  }
}
