import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:nwara_store_desktop/core/database/hive/inventory_model.dart';
part 'delete_inventory_item_state.dart';

class DeleteInventoryItemCubit extends Cubit<DeleteInventoryItemState> {
  DeleteInventoryItemCubit() : super(DeleteInventoryItemInitial());
  //final db = AppDatabaseSingleton().db;
  final box = Hive.box<InventoryModel>('inventory');

  void deleteInventoryItem(String id) async {
    try {
      emit(DeleteInventoryItemLoading());
      // await (db.delete(db.inventoryItems)
      //   ..where((tbl) => tbl.id.equals(id)))
      //     .go();
      final itemToDelete = box.values.firstWhere((item) => item.id == id);
      itemToDelete.delete();
      emit(DeleteInventoryItemSuccess());
    } catch (e) {
      emit(DeleteInventoryItemFailure(e.toString()));
    }
  }
}
