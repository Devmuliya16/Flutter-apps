import 'package:firebase_app/functions/auth%20functions.dart';
import 'package:firebase_app/pages/splash%20page.dart';
import 'package:flutter/material.dart';
import '../../widgets/borderinput.dart';

Column getLogin(
    TextEditingController emailController,
    TextEditingController passController,
    Function toggle,
    BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: Text("Login", style: TextStyle(fontSize: 50)),
      ),
      SizedBox(height: 20),
      BorderInput(inputController: emailController, label: "email"),
      SizedBox(height: 20),
      BorderInput(
          inputController: passController, label: "password", ispass: true),
      SizedBox(height: 20),
      ElevatedButton(
          onPressed: () async {
            await Login(emailController.text, passController.text);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SplashScreen(title: "Notes")));
          },
          child: Text("Login")),
      SizedBox(height: 5),
      TextButton(
          onPressed: () {
            toggle();
          },
          child: Text("dont have account ? - signup"))
    ],
  );
}
