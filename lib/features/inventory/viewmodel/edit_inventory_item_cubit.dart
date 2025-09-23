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
  int currentIndex = 0;
  final List<FocusNode> focusNodes = List.generate(3, (_) => FocusNode());



  //
  // void editInventoryItem({
  //   required String id,
  //   required int newQuantity,
  //   required double newPurchasedPrice,
  //   required double newSellPrice,
  //   required String title,
  // }) async {
  //   try {
  //
  //     if(!formKey.currentState!.validate()){
  //       return;
  //     }else{
  //       emit(EditInventoryItemLoading());
  //       quantityController.text = newQuantity.toString();
  //       purchasedPriceController.text = newPurchasedPrice.toString();
  //       sellingPriceController.text = newSellPrice.toString();
  //       // final item = box.values.firstWhere((element) => element.id == id);
  //       // item.quantity = int.parse(quantityController.text);
  //       // item.purchasedPrice = double.parse(purchasedPriceController.text);
  //       // item.sellPrice = double.parse(sellingPriceController.text);
  //       final item = InventoryModel(
  //           id: id,
  //           title: title,
  //           purchasedPrice: newPurchasedPrice,
  //           quantity: newQuantity,
  //           sellPrice: newSellPrice
  //       );
  //       await box.put(id, item);
  //
  //       emit(EditInventoryItemSuccess());
  //     }
  //
  //   } catch (e) {
  //     emit(EditInventoryItemFailure(e.toString()));
  //   }
  // }



  void initValues({
    required int quantity,
    required double purchasedPrice,
    required double sellPrice,
  }) {
    quantityController.text = quantity.toString();
    purchasedPriceController.text = purchasedPrice.toString();
    sellingPriceController.text = sellPrice.toString();
  }


  void editInventoryItem({
    required String id,
    required String title,
  }) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      } else {
        emit(EditInventoryItemLoading());

        final item = InventoryModel(
          id: id,
          title: title,
          purchasedPrice: double.parse(purchasedPriceController.text),
          quantity: int.parse(quantityController.text),
          sellPrice: double.parse(sellingPriceController.text),
        );

        await box.put(id, item);

        emit(EditInventoryItemSuccess());
      }
    } catch (e) {
      emit(EditInventoryItemFailure(e.toString()));
    }
  }


  @override
  Future<void> close() {
    quantityController.dispose();
    purchasedPriceController.dispose();
    sellingPriceController.dispose();
    for(var node in focusNodes){
      node.dispose();
    }
    return super.close();
  }
}
