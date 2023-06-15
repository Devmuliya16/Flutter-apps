import 'package:firebase_app/widgets/borderinput.dart';
import 'package:flutter/material.dart';

import '../functions/crud funtions.dart';

class TagsPage extends StatelessWidget {
  TagsPage({super.key, required this.title, required this.tags});
  final String title;
  final List<String> tags;
  final TextEditingController tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title)),
      body: Center(
        child: ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tags[index]),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteTag(tags[index]);
                    }),
              );
            }),
      ),
      bottomSheet: BottomAppBar(
        height: 80,
        child: ListTile(
          title: BorderInput(inputController: tagController, label: 'tag name'),
          trailing: TextButton(
              child: Text('Add'),
              onPressed: () {
                addTag(tagController.text);
                Navigator.pop(context);
              }),
        ),
      ),
    );
  }
}
