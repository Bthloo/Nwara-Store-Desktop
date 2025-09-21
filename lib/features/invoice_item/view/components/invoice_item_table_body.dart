import 'package:flutter/material.dart';
import 'package:nwara_store_desktop/features/invoice_item/viewmodel/get_invoive_cubit.dart';
import '../../../../core/database/hive/inventory_model.dart';
import '../../../home/view/components/inventory_row_cell.dart';
import 'invoice_item_cell.dart';

class InvoiceItemTableBody extends StatelessWidget {
  final List<InventoryModel> items;
  final GetInvoiceCubit getInvoiceCubit;
  final String invoiceId;

  const InvoiceItemTableBody({super.key, required this.items, required this.getInvoiceCubit,required this.invoiceId});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          border: Border(left: BorderSide(color: Color(0xFF9CABBA)), right: BorderSide(color: Color(0xFF9CABBA)), bottom: BorderSide(color: Color(0xFF9CABBA))),
        ),
        child: SingleChildScrollView(
          child: Table(
            children: List.generate(
              items.length,
                  (index) => TableRow(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xFF9CABBA), width: index == 0 ? 0 : 1)),
                ),
                children: [
                  InvoiceItemCell(
                    index: index,
                    invoiceId: invoiceId,
                    inventoryItemId: items[index].id,
                    itemName: items[index].title,
                    purchasePricePerItem: items[index].purchasedPrice,
                    quantitySold: items[index].quantity,
                    sellingPricePerItem: items[index].sellPrice ,
                    text: items[index].title,
                    isNumber: false,
                    getInvoiceCubit: getInvoiceCubit,
                  ),
                  InvoiceItemCell(
                    index: index,
                    invoiceId: invoiceId,
                    inventoryItemId: items[index].id,
                    itemName: items[index].title,
                    purchasePricePerItem: items[index].purchasedPrice,
                    quantitySold: items[index].quantity,
                    sellingPricePerItem: items[index].sellPrice ,
                    text: items[index].quantity.toString(),
                    getInvoiceCubit: getInvoiceCubit,

                  ),
                  InvoiceItemCell(
                    index: index,
                    invoiceId: invoiceId,
                    inventoryItemId: items[index].id,
                    itemName: items[index].title,
                    purchasePricePerItem: items[index].purchasedPrice,
                    quantitySold: items[index].quantity,
                    sellingPricePerItem: items[index].sellPrice ,
                    text: "${items[index].purchasedPrice * items[index].quantity}",
                    getInvoiceCubit: getInvoiceCubit,

                  ),
                  InvoiceItemCell(
                    index: index,
                    invoiceId: invoiceId,
                    inventoryItemId: items[index].id,
                    itemName: items[index].title,
                    purchasePricePerItem: items[index].purchasedPrice,
                    quantitySold: items[index].quantity,
                    sellingPricePerItem: items[index].sellPrice ,
                    text: "${items[index].sellPrice * items[index].quantity}",
                    getInvoiceCubit: getInvoiceCubit,

                  ),
                  InvoiceItemCell(
                    index: index,
                    invoiceId: invoiceId,
                    inventoryItemId: items[index].id,
                    itemName: items[index].title,
                    purchasePricePerItem: items[index].purchasedPrice,
                    quantitySold: items[index].quantity,
                    sellingPricePerItem: items[index].sellPrice ,
                    getInvoiceCubit: getInvoiceCubit,

                    text: "${(items[index].sellPrice * items[index].quantity) - (items[index].purchasedPrice * items[index].quantity)}",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
