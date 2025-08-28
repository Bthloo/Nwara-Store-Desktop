import 'package:flutter/material.dart';
import '../../../../core/database/hive/inventory_model.dart';
import '../../viewmodel/get_inventory_items_cubit.dart';
import 'inventory_table_bodey.dart';
import 'inventory_table_header.dart';

class InventoryTable extends StatelessWidget {
  final List<InventoryModel> items;
  final GetInventoryItemsCubit getCubit;

  const InventoryTable({super.key, required this.items, required this.getCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InventoryTableHeader(),
        InventoryTableBody(items: items, getCubit: getCubit),
      ],
    );
  }
}
