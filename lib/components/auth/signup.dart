import 'package:firebase_app/pages/splash%20page.dart';
import 'package:flutter/material.dart';
import '../../widgets/borderinput.dart';
import '../../functions/auth functions.dart';

Column getSignup(
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passController,
    Function toggle,
    BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        child: Text("Signup", style: TextStyle(fontSize: 50)),
      ),
      SizedBox(height: 20),
      BorderInput(inputController: nameController, label: "username"),
      SizedBox(height: 20),
      BorderInput(inputController: emailController, label: "email"),
      SizedBox(height: 20),
      BorderInput(
          inputController: passController, label: "password", ispass: true),
      SizedBox(height: 20),
      ElevatedButton(
          onPressed: () async {
            bool val = await Signup(
                nameController.text, emailController.text, passController.text);
            if (val)
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SplashScreen(title: "Notes")));
          },
          child: Text("Signup")),
      SizedBox(height: 5),
      TextButton(
          onPressed: () {
            toggle();
          },
          child: Text("already have account ? - login"))
    ],
  );
}
