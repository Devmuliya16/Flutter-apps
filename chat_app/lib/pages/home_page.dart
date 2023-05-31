import 'package:flutter/material.dart';
import 'package:chat_app/pages/chat_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('insert title'),
      ),
      body: Center(child: ChatScreen()),
    );
    ;
  }
}
