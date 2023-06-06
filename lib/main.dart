import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//pages
import 'package:firebase_app/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(title: "Notes"),
    );
  }
}
