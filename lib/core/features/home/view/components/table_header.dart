import 'package:flutter/material.dart';

class InvoiceHeaderCell extends StatelessWidget {
  final String text;

  const InvoiceHeaderCell({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 10, horizontal: 8),
        child: Text(text, style: TextStyle(
          fontSize: 18,
          color: Colors.white,

        ),),
      ),
    );
  }
}
