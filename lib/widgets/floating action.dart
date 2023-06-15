import 'package:flutter/material.dart';

class FAbutton extends StatelessWidget {
  FAbutton({super.key, this.fun, this.icon});
  Function? fun;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await this.fun!();
      },
      child: Icon(this.icon),
    );
  }
}
