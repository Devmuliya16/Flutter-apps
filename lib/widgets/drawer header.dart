import 'package:flutter/material.dart';

class getDrawerHeader extends StatelessWidget {
  const getDrawerHeader(
      {super.key,
      required this.name,
      required this.email,
      required this.profile});
  final String name, email, profile;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Image(
            image: NetworkImage(profile),
            fit: BoxFit.fitWidth,
            width: double.maxFinite,
            opacity: const AlwaysStoppedAnimation(.5),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListTile(
                tileColor: Colors.black,
                iconColor: Colors.white,
                textColor: Colors.white,
                title: Text(this.name),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(profile),
                ),
                subtitle: Text(this.email),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
