import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../components/custom_form_field.dart';

class InvoiceRowCell extends StatelessWidget {
 final String text;
 final bool isHeader;
 final bool isNumber;

   const InvoiceRowCell({super.key,required this.text,this.isHeader=false,this.isNumber=false,});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,

        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,

              builder: (context) {
                return AlertDialog(actionsAlignment: MainAxisAlignment.spaceBetween,

                  title: Text('تفاصيل المنتج'),
                  content: Column(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormField(
                          hintText: "hintText",
                          validator: (p0) {

                          },
                          controller: TextEditingController()
                      ),
                      CustomFormField(
                          hintText: "hintText",
                          validator: (p0) {

                          },
                          controller: TextEditingController()
                      ),
                      CustomFormField(
                          hintText: "hintText",
                          validator: (p0) {

                          },
                          controller: TextEditingController()
                      ),
                      CustomFormField(
                          hintText: "hintText",
                          validator: (p0) {

                          },
                          controller: TextEditingController()
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('إغلاق',style: TextStyle(
                          color: Colors.red
                      ),),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('حفظ'),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: isHeader ? 10 : 20, horizontal: 8),
            child: Text(text,style: TextStyle(
              fontSize: isHeader ? 18 : 16,
              color: isNumber ? Color(0xff9CABBA) : Colors.white,

            ),),
          ),
        ),
    );
  }
}
