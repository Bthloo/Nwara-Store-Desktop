import 'package:flutter/material.dart';

import '../../../home/view/components/table_header.dart';

class InvoiceTableHeader extends StatelessWidget {
  const InvoiceTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF9CABBA)),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: const Color(0xFF1C2126),
      ),
      child:  Table(
        children: [
          TableRow(children: [
            InvoiceHeaderCell(text: "اسم الفاتورة"),
            InvoiceHeaderCell(text: "تاريخ الإضافة"),
            InvoiceHeaderCell(text: "عدد المنتجات"),
            InvoiceHeaderCell(text: "صافي الربح"),
            InvoiceHeaderCell(text: "الحالة"),
          ]),
        ],
      ),
    );
  }
}
