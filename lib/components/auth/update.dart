import 'package:firebase_app/pages/splash%20page.dart';
import 'package:flutter/material.dart';
import '../../widgets/borderinput.dart';
import '../../functions/auth functions.dart';

Column getUpdate(
  TextEditingController nameController,
  TextEditingController emailController,
  TextEditingController passController,
  String url,
  BuildContext context,
  Function showSnackBar,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      InkWell(
        onTap: () async {
          await uploadProfile();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SplashScreen(title: 'Notes')));
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(url),
          radius: 100,
        ),
      ),
      SizedBox(height: 20),
      ListTile(
          title:
              BorderInput(inputController: nameController, label: "username"),
          trailing: TextButton(
            onPressed: () async {
              showSnackBar(await Updatename(nameController.text));
            },
            child: Text('Update'),
          )),
      SizedBox(height: 20),
      ListTile(
          title: BorderInput(inputController: emailController, label: "email"),
          trailing: TextButton(
            onPressed: () async {
              showSnackBar(await Updateemail(emailController.text));
            },
            child: Text('Update'),
          )),
      SizedBox(height: 20),
      ListTile(
          title:
              BorderInput(inputController: passController, label: "password"),
          trailing: TextButton(
            onPressed: () async {
              showSnackBar(await Updatepassword(passController.text));
            },
            child: Text('Update'),
          )),
    ],
  );
}
