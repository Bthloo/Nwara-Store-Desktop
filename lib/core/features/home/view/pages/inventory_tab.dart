import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nwara_store_desktop/core/components/color_helper.dart';
import 'package:nwara_store_desktop/core/components/custom_form_field.dart';

import '../components/invoice_row_cell.dart';

class InventoryTab extends StatelessWidget {
  const InventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المخزن"),
        centerTitle: false,
      ),
      bottomNavigationBar: BottomAppBar(
        color: ColorHelper.darkColor,
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('اضافة منتج جديد'),
                      content: Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFormField(
                            hintText: "اسم المنتج",
                            validator: (p0) {},
                            controller: TextEditingController(),
                          ),
                          CustomFormField(
                            hintText: "الكمية",
                            validator: (p0) {},
                            controller: TextEditingController(),
                          ),
                          CustomFormField(
                            hintText: "سعر الشراء",
                            validator: (p0) {},
                            controller: TextEditingController(),
                          ),
                          CustomFormField(
                            hintText: "سعر البيع",
                            validator: (p0) {},
                            controller: TextEditingController(),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'الغاء',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('اضافه'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("اضافة منتج جديد"),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                border: Border.all(color: Colors.white),
              ),
              child: Table(
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: Border.all(),
                      color: const Color(0xFF1C2126),
                    ),
                    children: const [
                      InvoiceRowCell(text: "اسم المنتج", isHeader: true),
                      InvoiceRowCell(text: "الكمية", isHeader: true),
                      InvoiceRowCell(text: "سعر الشراء", isHeader: true),
                      InvoiceRowCell(text: "سعر البيع", isHeader: true),
                      InvoiceRowCell(text: "صافي الربح", isHeader: true),
                    ],
                  ),
                ],
              ),
            ),

            /// الصفوف
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border(
                    right: BorderSide(color: Colors.white),
                    left: BorderSide(color: Colors.white),
                    bottom: BorderSide(color: Colors.white),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
                  child: SingleChildScrollView(
                    child: Table(
                      children: List.generate(
                       20,
                            (index) => TableRow(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: index == 0 ? 0 : 1,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          children: const [
                            InvoiceRowCell(text: 'anker'),
                            InvoiceRowCell(text: '10', isNumber: true),
                            InvoiceRowCell(text: '10', isNumber: true),
                            InvoiceRowCell(text: '10', isNumber: true),
                            InvoiceRowCell(text: '10', isNumber: true),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
