import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/features/invoice_item/viewmodel/delete_item_from_invoice_cubit.dart';
import 'package:nwara_store_desktop/features/invoice_item/viewmodel/get_invoive_cubit.dart';

class InvoiceItemCell extends StatelessWidget {
  final String text;
  final bool isNumber;
  final String itemName;
  final int quantitySold;
  final double purchasePricePerItem;
  final double sellingPricePerItem;
  final String invoiceId;
  final String inventoryItemId;
  final int index;
  final GetInvoiceCubit getInvoiceCubit;
  const InvoiceItemCell({
    super.key,
    required this.text,
    this.isNumber = true,
    required this.itemName,
    required this.quantitySold,
    required this.purchasePricePerItem,
    required this.sellingPricePerItem,
    required this.invoiceId,
    required this.inventoryItemId,
    required this.index,
    required this.getInvoiceCubit,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("اغلاق"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => DeleteItemFromInvoiceCubit(),
                            child:
                                BlocConsumer<
                                  DeleteItemFromInvoiceCubit,
                                  DeleteItemFromInvoiceState
                                >(
                                  listener: (context, state) {
                                    if(state is DeleteItemFromInvoiceSuccess) {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("تم مسح العنصر بنجاح"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else if (state is DeleteItemFromInvoiceFailure) {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(state.errorMessage),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return AlertDialog(
                                      title: Row(
                                        children: [
                                          Text("هل انت متاكد من مسح "),
                                          SizedBox(width: 5),
                                          Text(
                                            itemName,
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            "؟",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: state is DeleteItemFromInvoiceLoading
                                          ? [
                                              Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ]
                                          :
                                      [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("الغاء"),
                                        ),

                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<
                                                  DeleteItemFromInvoiceCubit
                                                >()
                                                .deleteItemFromInvoice(
                                                  invoiceId: invoiceId,
                                                  inventoryItemId:
                                                      inventoryItemId,
                                                  quantity: quantitySold,
                                              index: index
                                                );
                                          },
                                          child: Text(
                                            "مسح",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          );
                        },
                      ).then((value) {
                        getInvoiceCubit.getInvoiceById(invoiceId);
                      },);
                    },
                    child: Text("مسح", style: TextStyle(color: Colors.red)),
                  ),
                ],
                title: Text(itemName, textAlign: TextAlign.center),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("الكميه المباعة"),
                        SizedBox(width: 10),
                        Text(quantitySold.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("سعر الشراء للقطعه"),
                        SizedBox(width: 10),
                        Text(purchasePricePerItem.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("سعر البيع للقطعه"),
                        SizedBox(width: 10),
                        Text(sellingPricePerItem.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("صافي الربح  للقطعه"),
                        SizedBox(width: 10),
                        Text(
                          (sellingPricePerItem - purchasePricePerItem)
                              .toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
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
