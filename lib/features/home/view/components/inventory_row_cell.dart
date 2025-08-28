import 'package:flutter/material.dart';
import '../../../inventory/view/components/item_details_dialog.dart';
import '../../../inventory/viewmodel/get_inventory_items_cubit.dart';

class InventoryRowCell extends StatelessWidget {
  final String text;
  final bool isNumber;
  final String title;
  final double purchasedPrice;
  final int quantity;
  final double sellPrice;
  final String id;
  final GetInventoryItemsCubit getItemCubit;

  const InventoryRowCell({
    super.key,
    required this.text,
    this.isNumber = false,
    required this.title,
    required this.purchasedPrice,
    required this.quantity,
    required this.sellPrice,
    required this.id,
    required this.getItemCubit,
  });

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
              return ItemDetailsDialog(
                  title: title,
                  purchasedPrice: purchasedPrice,
                  quantity: quantity, sellPrice:
              sellPrice, id: id, getItemCubit:
              getItemCubit
              );
           },
          );
          // context.read<GetInventoryItemsCubit>().getAllInventoryItems();
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
