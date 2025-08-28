import 'package:flutter/material.dart';

import '../../../home/view/components/table_header.dart';

class InventoryTableHeader extends StatelessWidget {
  const InventoryTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: const Color(0xFF1C2126),
      ),
      child:  Table(
        children: [
          TableRow(children: [
            InvoiceHeaderCell(text: "اسم المنتج"),
            InvoiceHeaderCell(text: "الكمية"),
            InvoiceHeaderCell(text: "سعر الشراء"),
            InvoiceHeaderCell(text: "سعر البيع المبدئي"),
            InvoiceHeaderCell(text: "صافي الربح المتوقع"),
          ]),
        ],
      ),
    );
  }
}
