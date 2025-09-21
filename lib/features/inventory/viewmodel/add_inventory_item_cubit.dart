import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:nwara_store_desktop/core/database/hive/inventory_model.dart';

part 'add_inventory_item_state.dart';

class AddInventoryItemCubit extends Cubit<AddInventoryItemState> {
  AddInventoryItemCubit() : super(AddInventoryItemInitial());
 // final db = AppDatabaseSingleton().db;
  final box = Hive.box<InventoryModel>('inventory');

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
        final newItem = InventoryModel(
          id: "${titleController.text}${DateTime.now().millisecondsSinceEpoch}",
          title: titleController.text,
          purchasedPrice: double.parse(purchasedPriceController.text),
          quantity: int.parse(quantityController.text),
          sellPrice: double.parse(sellingPriceController.text),
        );
        await box.put(newItem.id,newItem);

        emit(AddInventoryItemSuccess());
      } catch (e) {
        debugPrint(e.toString());
        emit(AddInventoryItemFailure(e.toString()));
      }
    }


  }

  @override
  Future<void> close() {
    titleController.dispose();
    quantityController.dispose();
    purchasedPriceController.dispose();
    sellingPriceController.dispose();
    return super.close();
  }
}
