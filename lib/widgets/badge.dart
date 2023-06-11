import 'package:flutter/material.dart';

class getBadge extends StatelessWidget {
  const getBadge({super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    if (this.title == "")
      return Container();
    else
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: this.color,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 40,
          child: Text(
            '#' + this.title,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: this.color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }
}
