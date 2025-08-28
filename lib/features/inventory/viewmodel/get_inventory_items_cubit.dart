import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import '../../../core/database/hive/inventory_model.dart';
part 'get_inventory_items_state.dart';

class GetInventoryItemsCubit extends Cubit<GetInventoryItemsState> {
  GetInventoryItemsCubit() : super(GetInventoryItemsInitial());
  //static GetInventoryItemsCubit of(context) => BlocProvider.of<GetInventoryItemsCubit>(context);
 // final db = AppDatabaseSingleton().db;
  final box = Hive.box<InventoryModel>('inventory');
  List<InventoryModel> allItems = [];

  getAllInventoryItems() async {
    try {
      emit(GetInventoryItemsLoading());
     // final items = await db.select(db.inventoryItems).get();
     final items = box.values.toList();
      allItems = items;
      emit(GetInventoryItemsSuccess(items));
    } catch (e) {
      emit(GetInventoryItemsFailure(e.toString()));
    }
  }


  void filterItems(String query) {
    if (query.isEmpty) {
      emit(GetInventoryItemsSuccess(allItems));
    } else {
      final filtered = allItems.where((item) {
        final title = item.title.toLowerCase();
        final q = query.toLowerCase();

        return title.contains(q) ||
            item.quantity.toString().contains(q) ||
            item.purchasedPrice.toString().contains(q) ||
            item.sellPrice.toString().contains(q);
      }).toList();

      emit(GetInventoryItemsSuccess(filtered));
    }
  }
}
