import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../database/database_singlton.dart';

part 'delete_inventory_item_state.dart';

class DeleteInventoryItemCubit extends Cubit<DeleteInventoryItemState> {
  DeleteInventoryItemCubit() : super(DeleteInventoryItemInitial());
  final db = AppDatabaseSingleton().db;
  void deleteInventoryItem(int id) async {
    try {
      emit(DeleteInventoryItemLoading());
      await (db.delete(db.inventoryItems)
        ..where((tbl) => tbl.id.equals(id)))
          .go();
      emit(DeleteInventoryItemSuccess());
    } catch (e) {
      emit(DeleteInventoryItemFailure(e.toString()));
    }
  }
}
