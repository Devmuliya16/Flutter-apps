import 'package:flutter/material.dart';

class getEditNote extends StatelessWidget {
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
  Widget build(BuildContext context) {
    titleController.text = this.note != null ? this.note['title'] : "";
    noteController.text = this.note != null ? this.note['note'] : "";
    return Column(
      children: [
        TextField(
          controller: titleController,
          maxLines: 1,
          autocorrect: true,
          style: TextStyle(fontSize: 30),
          decoration: InputDecoration(hintText: 'Note title'),
        ),
        SizedBox(height: 20),
        Expanded(
          child: TextField(
            controller: noteController,
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
}
