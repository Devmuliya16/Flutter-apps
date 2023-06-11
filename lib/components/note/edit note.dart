import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0.0, 4.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('Pick a color!'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: Colors.red,
                                  onColorChanged: (Color color) {
                                    setState(() {
                                      print(color);
                                    });
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('DONE'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ]);
                        });
                  },
                  child: Text('pick color'),
                ),
              ],
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
