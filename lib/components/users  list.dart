import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getList extends StatefulWidget {
  const getList({super.key});

  @override
  State<getList> createState() => _getListState();
}

class _getListState extends State<getList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("loading"));
        } else {
          var data = snapshot.data!.docs ?? [];
          return Container(
            height: 300,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]['name'] ?? 'name'),
                  subtitle: Text(data[index]['type'] ?? 'type'),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
