import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/color_helper.dart';
import 'package:nwara_store_desktop/core/components/custom_form_field.dart';
import 'package:nwara_store_desktop/core/features/inventory/viewmodel/add_inventory_item_cubit.dart';
import 'package:nwara_store_desktop/core/features/inventory/viewmodel/get_inventory_items_cubit.dart';
import '../../../home/view/components/invoice_row_cell.dart';
import '../../../home/view/components/table_header.dart';
import '../components/add_item_dialog.dart';
import '../components/inventory_table.dart';

class InventoryTab extends StatelessWidget {
  const InventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => GetInventoryItemsCubit()..getAllInventoryItems(),
  child: Builder(
    builder: (context) {
      final getCubit = context.read<GetInventoryItemsCubit>();
      return Scaffold(
          appBar: AppBar(title: const Text("المخزن"), centerTitle: false),
          bottomNavigationBar: BottomAppBar(
            color: ColorHelper.darkColor,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (dialogContext) {
                        return AddInventoryItemDialog(getCubit: getCubit);
                      },
                    );
                  },
                  child: const Text("اضافة منتج جديد"),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<GetInventoryItemsCubit, GetInventoryItemsState>(
              builder: (context, getInventoryItemsState) {
                if (getInventoryItemsState is GetInventoryItemsLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (getInventoryItemsState is GetInventoryItemsFailure) {
                  return Center(
                    child: Text(
                      getInventoryItemsState.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (getInventoryItemsState is GetInventoryItemsSuccess) {
                  final items = getInventoryItemsState.items;
                  if (items.isEmpty) {
                    return const Center(child: Text("لا يوجد منتجات في المخزن"));
                  } else {
                    return InventoryTable(items: items, getCubit: getCubit);
                  }
                } else {
                  return Center(
                    child: Text(
                      "حدث خطأ غير معروف",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
              },
            ),
          ),
        );
    }
  ),
);
  }
}
