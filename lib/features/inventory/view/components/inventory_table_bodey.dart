import 'package:flutter/material.dart';
import '../../../../core/database/hive/inventory_model.dart';
import '../../../home/view/components/inventory_row_cell.dart';
import '../../viewmodel/get_inventory_items_cubit.dart';

class InventoryTableBody extends StatelessWidget {
  final List<InventoryModel> items;
  final GetInventoryItemsCubit getCubit;

  const InventoryTableBody({super.key, required this.items, required this.getCubit});

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
                  InventoryRowCell(
                    text: items[index].title,
                    isNumber: false,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
                  ),
                  InventoryRowCell(
                    text: items[index].quantity.toString(),
                    isNumber: true,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
                  ),
                  InventoryRowCell(
                    text: items[index].purchasedPrice.toString(),
                    isNumber: true,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
                  ),
                  InventoryRowCell(
                    text: items[index].sellPrice.toString(),
                    isNumber: true,
                    title: items[index].title,
                    purchasedPrice: items[index].purchasedPrice,
                    quantity: items[index].quantity,
                    sellPrice: items[index].sellPrice,
                    id: items[index].id,
                    getItemCubit: getCubit,
                  ),
                  InventoryRowCell(
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
