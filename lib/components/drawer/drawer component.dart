import 'package:firebase_app/functions/auth%20functions.dart';
import 'package:firebase_app/pages/addtag_page.dart';
import 'package:flutter/material.dart';

import '../../functions/crud funtions.dart';
import '../../pages/auth_page.dart';
import '../../pages/update_page.dart';
import '../../widgets/drawer header.dart';

final defaulturl =
    "https://www.dmarge.com/wp-content/uploads/2021/01/dwayne-the-rock-.jpg";

class DrawerComp extends StatefulWidget {
  DrawerComp(
      {super.key, required this.auth, required this.setOpt, required this.str});
  final auth;
  final String str;
  Function setOpt;

  @override
  State<DrawerComp> createState() => _DrawerCompState();
}

class _DrawerCompState extends State<DrawerComp> {
  List<String> tags = [];
  Map<String, dynamic> userinfo = {};
  @override
  void initState() {
    initializeTags();
  }

  Future<void> initializeTags() async {
    userinfo = await getUserInfo();
    List<String> fetchedTags = await fetchTags();
    setState(() {
      tags = fetchedTags;
    });
  }

  @override
  Widget build(BuildContext context) {
    void logout() {
      widget.auth
          .signOut()
          .then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => AuthPage(title: "Notes"))))
          .onError((error, stackTrace) => print(error));
    }

    return Drawer(
      child: Column(
        children: [
          getDrawerHeader(
              name: userinfo['username'] ?? "",
              email: userinfo['email'] ?? "",
              profile: userinfo['profile'] ?? defaulturl),
          ListTile(
              onTap: () {
                widget.setOpt(0, '');
                Navigator.pop(context);
              },
              selected: widget.str == '',
              title: Text(
                'Get all Notes',
                style: TextStyle(fontSize: 20),
              )),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    widget.setOpt(1, tags[index]);
                    Navigator.pop(context);
                  },
                  selectedTileColor: const Color.fromARGB(104, 33, 149, 243),
                  selected: tags[index] == widget.str,
                  leading: Icon(Icons.tag),
                  title: Text(
                    tags[index],
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                );
              },
              itemCount: tags.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.add_home_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TagsPage(title: 'Manage Tags', tags: tags)));
                },
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  logout();
                },
              ),
              IconButton(
                icon: Icon(Icons.settings_outlined),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePage(title: "Edit Info"),
                      ));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
