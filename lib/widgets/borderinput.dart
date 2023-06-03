import 'package:flutter/material.dart';

class BorderInput extends StatefulWidget {
  BorderInput(
      {super.key,
      required this.inputController,
      required this.label,
      this.color = Colors.blue,
      this.placeholder = "",
      this.padding = 20,
      this.ispass = false});

  final TextEditingController inputController;
  final String label;
  final String? placeholder;
  final Color color;
  final double padding;
  final bool ispass;

  @override
  State<BorderInput> createState() => _BorderInputState();
}

class _BorderInputState extends State<BorderInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: widget.color,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        labelText: widget.label,
      ),
      controller: widget.inputController,
      obscureText: widget.ispass,
    );
  }
}
