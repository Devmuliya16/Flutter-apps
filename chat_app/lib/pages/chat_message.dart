import 'package:flutter/material.dart';

const String _name = "Flutter Developer";

class ChatMessage extends StatelessWidget {
  final String text;
  ChatMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(
                child: new Text(_name[0]),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.red,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey),
                    padding: EdgeInsets.all(16),
                    child: Text(text))),
          ),
        ),
      ],
    );
  }
}
