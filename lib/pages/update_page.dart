import 'package:firebase_app/components/auth/update.dart';
import 'package:flutter/material.dart';

import '../functions/auth functions.dart';
import '../widgets/snackbar.dart';

final defaulturl =
    "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg";

class UpdatePage extends StatefulWidget {
  UpdatePage({super.key, required this.title});
  final String title;
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  Map<String, dynamic> userinfo = {};
  void initState() {
    initializeTags();
  }

  Future<void> initializeTags() async {
    userinfo = await getUserInfo();
  }

  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(getSnackBar(message, () {}));
    }

    rebuild() {
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: getUpdate(
              nameController,
              emailController,
              passController,
              userinfo['profile'] ?? defaulturl,
              context,
              showSnackBar,
              rebuild),
        ),
      )),
    );
  }
}
