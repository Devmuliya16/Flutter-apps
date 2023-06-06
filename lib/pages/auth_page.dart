import 'package:flutter/material.dart';

//components
import '../components/auth/login.dart';
import '../components/auth/signup.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key, required this.title});
  final String title;
  bool login = true;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController namexController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: widget.login
                ? getLogin(emailController, passController, _toggle, context)
                : getSignup(namexController, emailController, passController,
                    _toggle, context),
          ),
        ],
      )),
    );
  }

  _toggle() {
    setState(() {
      widget.login = !widget.login;
      namexController.clear();
      emailController.clear();
      passController.clear();
    });
  }
}
