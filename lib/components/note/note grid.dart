import 'package:firebase_app/functions/util%20functions.dart';
import 'package:firebase_app/pages/edit%20note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../widgets/badge.dart';

class NotesGrid extends StatefulWidget {
  NotesGrid({super.key, required this.crossAxiscnt, required this.data});
  late int crossAxiscnt;
  late var data;

  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    openEditor(var note) async {
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditNote(title: "Edit Note", note: note)));
    }

    return MasonryGridView.count(
        crossAxisCount: widget.crossAxiscnt,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              openEditor(widget.data[index]);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black),
                  color: Colors.white),
              child: Note(
                note: widget.data[index],
              ),
            ),
          );
        });
  }
}

class Note extends StatelessWidget {
  const Note({super.key, required this.note});
  final note;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(this.note['title'] ?? "",
                style: Theme.of(context).textTheme.titleLarge),
          ),
          getBadge(title: this.note['tag'], color: Colors.lightBlue)
        ],
      ),
      Text(this.note['note'] ?? ""),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            UtilFun.getRelativeTime(this.note['updated']),
            style: Theme.of(context).textTheme.labelSmall,
          )
        ],
      )
    ]);
  }
}
