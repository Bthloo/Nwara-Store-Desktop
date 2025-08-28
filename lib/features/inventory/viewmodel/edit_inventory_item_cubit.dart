import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import '../../../core/database/hive/inventory_model.dart';
part 'edit_inventory_item_state.dart';

class EditInventoryItemCubit extends Cubit<EditInventoryItemState> {
  EditInventoryItemCubit() : super(EditInventoryItemInitial());
  //final db = AppDatabaseSingleton().db;
  final box = Hive.box<InventoryModel>('inventory');

  final formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();
  final purchasedPriceController = TextEditingController();
  final sellingPriceController = TextEditingController();

  void editInventoryItem({
    required String id,
    required int newQuantity,
    required double newPurchasedPrice,
    required double newSellPrice,
  }) async {
    try {
      emit(EditInventoryItemLoading());
      quantityController.text = newQuantity.toString();
      purchasedPriceController.text = newPurchasedPrice.toString();
      sellingPriceController.text = newSellPrice.toString();
      final item = box.values.firstWhere((element) => element.id == id);
      item.quantity = int.parse(quantityController.text);
      item.purchasedPrice = double.parse(purchasedPriceController.text);
      item.sellPrice = double.parse(sellingPriceController.text);
      await item.save();
      emit(EditInventoryItemSuccess());
    } catch (e) {
      emit(EditInventoryItemFailure(e.toString()));
    }
  }

  @override
  Future<void> close() {
    quantityController.dispose();
    purchasedPriceController.dispose();
    sellingPriceController.dispose();
    return super.close();
  }
}
