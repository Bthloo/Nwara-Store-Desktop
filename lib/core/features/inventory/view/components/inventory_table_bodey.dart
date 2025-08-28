import 'package:flutter/material.dart';
import 'package:nwara_store_desktop/core/database/models/inventory_model.dart';

import '../../../../database/app_database.dart';
import '../../../home/view/components/invoice_row_cell.dart';
import '../../viewmodel/get_inventory_items_cubit.dart';

class InventoryTableBody extends StatelessWidget {
  final List<InventoryItem> items;
  final GetInventoryItemsCubit getCubit;

  const InventoryTableBody({super.key, required this.items, required this.getCubit});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          border: Border(left: BorderSide(color: Colors.white), right: BorderSide(color: Colors.white), bottom: BorderSide(color: Colors.white)),
        ),
        child: SingleChildScrollView(
          child: Table(
            children: List.generate(
              items.length,
                  (index) => TableRow(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.white, width: index == 0 ? 0 : 1)),
                ),
                children: [
                  InvoiceRowCell(
                    text: items[index].title,
                    isNumber: false,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
                  ),
                  InvoiceRowCell(
                    text: items[index].quantity.toString(),
                    isNumber: true,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
                  ),
                  InvoiceRowCell(
                    text: items[index].purchasedPrice.toString(),
                    isNumber: true,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
                  ),
                  InvoiceRowCell(
                    text: items[index].sellPrice.toString(),
                    isNumber: true,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
                  ),
                  InvoiceRowCell(
                    text: (items[index].sellPrice - items[index].purchasedPrice).toString(),
                    isNumber: true,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
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
