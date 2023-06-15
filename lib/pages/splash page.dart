// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

//functions
import 'package:firebase_app/functions/auth%20functions.dart';

//pages
import 'package:firebase_app/pages/home%20page.dart';
import 'package:flutter/scheduler.dart';
import 'authentication page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});
  final String title;
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  bool result = false;
  @override
  void initState() {
    super.initState();
    result = isLoggedin();
    print(result);
    if (result) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage(title: "Notes")));
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AuthPage(title: "Notes")));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          widget.title,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white),
        ),
      ),
    );
  }
}
