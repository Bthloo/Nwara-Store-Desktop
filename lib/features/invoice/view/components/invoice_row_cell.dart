import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spoiler_widget/models/spoiler_configs.dart';
import 'package:spoiler_widget/models/widget_spoiler.dart';
import 'package:spoiler_widget/spoiler_overlay_widget.dart';

class InvoiceRowCell extends StatelessWidget {
  final String text;
  final bool isNumber;
  final void Function()? onTap;

   const InvoiceRowCell({super.key,required this.text,this.isNumber = true,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isNumber ? Color(0xff9CABBA) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
