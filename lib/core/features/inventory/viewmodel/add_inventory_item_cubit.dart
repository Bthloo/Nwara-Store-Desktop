import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:nwara_store_desktop/core/database/app_database.dart';

import '../../../database/database_singlton.dart';

part 'add_inventory_item_state.dart';

class AddInventoryItemCubit extends Cubit<AddInventoryItemState> {
  AddInventoryItemCubit() : super(AddInventoryItemInitial());
  final db = AppDatabaseSingleton().db;

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final quantityController = TextEditingController();
  final purchasedPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  void addItem() async {

    if(!formKey.currentState!.validate()){
      return;
    }else{
      try {
        emit(AddInventoryItemLoading());
        await db.into(db.inventoryItems).insert(
            InventoryItemsCompanion.insert(
              title: titleController.text,
              purchasedPrice: double.parse(purchasedPriceController.text),
              quantity: int.parse(quantityController.text),
              sellPrice: double.parse(sellingPriceController.text),
            )
        );

        emit(AddInventoryItemSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(AddInventoryItemFailure(e.toString()));
      }
    }


  }
}
