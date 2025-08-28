import 'package:flutter/material.dart';
import 'package:nwara_store_desktop/core/components/color_helper.dart';

class InvoiceItem extends StatelessWidget {
  const InvoiceItem({super.key});
static const String routeName = "invoice_item";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("عنصر الفاتورة"), centerTitle: false),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width*0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text("تفاصيل الفاتورة",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 20,),
                  ListTile(
                    title: Text("اجمالي سعر الشراء",style: TextStyle(
                        fontSize: 18,
                        color: ColorHelper.secondaryColor
                    ),),
                    trailing: Text("300",style: TextStyle(
                      fontSize: 18
                    ),),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("اجمالي سعر البيع",style: TextStyle(
                        fontSize: 18,
                      color: ColorHelper.secondaryColor
                    ),),
                    trailing: Text("400",style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("عدد العناصر",style: TextStyle(
                        fontSize: 18,
                        color: ColorHelper.secondaryColor
                    ),),
                    trailing: Text("6",style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("صافي الربح",style: TextStyle(
                        fontSize: 18,
                        color: ColorHelper.secondaryColor
                    ),),
                    trailing: Text("100",style: TextStyle(
                        fontSize: 18
                    ),),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
