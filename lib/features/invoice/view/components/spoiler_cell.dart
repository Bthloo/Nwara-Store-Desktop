import 'dart:ui';
import 'package:flutter/material.dart';

class SpoilerCell extends StatefulWidget {
  final String text;

  const SpoilerCell({
    super.key,
    required this.text,
  });

  @override
  State<SpoilerCell> createState() => _SpoilerCellState();
}

class _SpoilerCellState extends State<SpoilerCell> {
  bool revealed = false;

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: InkWell(
        onTap: () {
          setState(() {

            revealed = !revealed;
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: revealed ? Text(
            widget.text,
            style: TextStyle(
              fontSize: 16,
              color:Color(0xff9CABBA),
            ),
          ) :
          Icon(Icons.visibility_off,color: Color(0xff9CABBA),size: 20,)
          ,
        ),
      ),
    );
  }
}
