import 'package:flutter/material.dart';

import '../functions/crud funtions.dart';

Column getCrud() {
  return Column(
    children: [
      ElevatedButton(
          onPressed: () {
            create();
          },
          child: Text("create")),
      ElevatedButton(
          onPressed: () {
            update();
          },
          child: Text("update")),
      ElevatedButton(
          onPressed: () {
            read();
          },
          child: Text("read")),
      ElevatedButton(
          onPressed: () {
            delete();
          },
          child: Text("delete")),
    ],
  );
}
