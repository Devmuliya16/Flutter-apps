import 'package:firebase_app/components/note/edit%20note.dart';
import 'package:firebase_app/functions/crud%20funtions.dart';
import 'package:firebase_app/widgets/colors.dart';
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
  int? selectedColor;
  final auth = FirebaseAuth.instance;
  List<String> tags = [];
  @override
  void initState() {
    initializeTags();
  }

  Future<void> initializeTags() async {
    List<String> fetchedTags = await fetchTags();
    setState(() {
      tags = fetchedTags;
      selectedTag = widget.note['tag'];
      selectedColor = widget.note['color'];
    });
  }

  selectTag(String tag) {
    setState(() {
      selectedTag = tag;
    });
  }

  selectColor(int index) {
    setState(() {
      selectedColor = index;
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
          IconButton(
              onPressed: () async {
                if (widget.note == null)
                  create(titleController.text, noteController.text,
                      selectedColor ?? 0, selectedTag ?? "");
                else
                  update(
                      titleController.text,
                      noteController.text,
                      selectedColor ?? 0,
                      widget.note['time'],
                      selectedTag ?? "");
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return getBottomsheet(
                      tags, selectedTag, selectedColor, selectTag, selectColor);
                });
          },
          child: Icon(Icons.edit)),
    );
  }
}

Container getBottomsheet(dynamic tags, String? selectedTag, int? selectedColor,
    Function selectTag, Function selectColor) {
  print(selectedColor);
  return Container(
    height: 200,
    child: Column(
      children: [
        DropdownComp(
          tags: tags,
          selectedTag: selectedTag,
          selectTag: selectTag,
        ),
        Container(
          child: ListTile(
            title: Wrap(
              spacing: 5,
              children: List.generate(
                noteColors.length,
                (index) => GestureDetector(
                  onTap: () {
                    selectColor(index);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: noteColors[index],
                          shape: BoxShape.circle,
                        ),
                      ),
                      (selectedColor == index)
                          ? Icon(Icons.check, size: 18)
                          : Container(width: 18)
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
