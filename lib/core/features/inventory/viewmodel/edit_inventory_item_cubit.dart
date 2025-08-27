import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../database/app_database.dart';
import '../../../database/database_singlton.dart';

part 'edit_inventory_item_state.dart';

class EditInventoryItemCubit extends Cubit<EditInventoryItemState> {
  EditInventoryItemCubit() : super(EditInventoryItemInitial());
  final db = AppDatabaseSingleton().db;
  final formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();
  final purchasedPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();

  void editInventoryItem({
    required int id,
    required int newQuantity,
    required double newPurchasedPrice,
    required double newSellPrice,
  }) async {
    try {
      emit(EditInventoryItemLoading());
      quantityController.text = newQuantity.toString();
      purchasedPriceController.text = newPurchasedPrice.toString();
      sellingPriceController.text = newSellPrice.toString();
      await (db.update(db.inventoryItems)
        ..where((tbl) => tbl.id.equals(id)))
          .write(
        InventoryItemsCompanion(
          quantity: Value(int.parse(quantityController.text)),
          purchasedPrice: Value(double.parse(purchasedPriceController.text)),
          sellPrice: Value(double.parse(sellingPriceController.text)),
        ),
      );
      emit(EditInventoryItemSuccess());
    } catch (e) {
      emit(EditInventoryItemFailure(e.toString()));
    }
  }
}
