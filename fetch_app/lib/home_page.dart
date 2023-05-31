import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.title});
  late String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List data;
  final String url = "https://swapi.dev/api/people";
  @override
  void initState() {
    this.getData();
  }

  void getData() async {
    var response = await http
        .get(Uri.parse(this.url), headers: {'Accept': "application/json"});
    setState(() {
      this.data = json.decode(response.body)['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: data.length == null ? 0 : data.length,
          itemBuilder: (context, index) {
            return Container(
              child: Center(
                  child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("name: " + data[index]['name']),
                      Text("height: " + data[index]['height']),
                      Text("mass: " + data[index]['mass']),
                      Text("birth year: " + data[index]['birth_year']),
                      Text("gender: " + data[index]['gender']),
                    ],
                  ),
                ),
              )),
            );
          }),
    );
  }
}
