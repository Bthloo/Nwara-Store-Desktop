import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/color_helper.dart';

class CustomExpantion extends StatefulWidget {
  final double totalPurchasePrice;
  final double totalSellPrice;
  final double netProfit;

  const CustomExpantion({super.key,required this.totalPurchasePrice,required this.totalSellPrice,required this.netProfit});

  @override
  State<CustomExpantion> createState() => _CustomExpantionState();
}

class _CustomExpantionState extends State<CustomExpantion> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff1c2023),
      child: ExpansionTile(
        expandedAlignment: Alignment.topLeft,
        collapsedIconColor: ColorHelper.secondaryColor,
        iconColor: ColorHelper.secondaryColor,
        shape: const Border(),
        collapsedShape: const Border(),
        onExpansionChanged: (value) {
          setState(() => isOpen = value);
        },
        title: Text(
          !isOpen ? "عرض التفاصيل" : "إخفاء التفاصيل",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorHelper.secondaryColor,
          ),
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  "اجمالي سعر الشراء",
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorHelper.secondaryColor,
                  ),
                ),
                trailing: Text(
                  widget.totalPurchasePrice.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "اجمالي سعر البيع",
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorHelper.secondaryColor,
                  ),
                ),
                trailing: Text(
                  widget.totalSellPrice.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "صافي الربح",
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorHelper.secondaryColor,
                  ),
                ),
                trailing: Text(
                  widget.netProfit.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              // const Divider(),
              // ListTile(
              //   title: Text(
              //     "dfdfdfdf",
              //     style: TextStyle(
              //       fontSize: 18,
              //       color: ColorHelper.secondaryColor,
              //     ),
              //   ),
              //   trailing: Text(
              //     "value",
              //     style: const TextStyle(fontSize: 18),
              //   ),
              // ),

            ],
          ),
        ],
      ),
    );
  }

}
