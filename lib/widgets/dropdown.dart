import 'package:flutter/material.dart';

class DropdownComp extends StatefulWidget {
  DropdownComp(
      {super.key,
      required this.tags,
      required this.selectedTag,
      required this.selectTag});
  final tags;
  late var selectedTag;
  final Function selectTag;
  @override
  State<DropdownComp> createState() => _DropdownCompState();
}

class _DropdownCompState extends State<DropdownComp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String?>(
          isExpanded: false,
          isDense: true,
          hint: Text("choose tag"),
          underline: Container(),
          value: widget.selectedTag == "" ? null : widget.selectedTag,
          onChanged: (String? newValue) {
            setState(() {
              widget.selectedTag = newValue;
              widget.selectTag(newValue);
            });
          },
          items: [
            for (String tag in widget.tags)
              DropdownMenuItem<String>(
                value: tag,
                child: Text(tag),
              ),
          ]),
    );
  }
}
