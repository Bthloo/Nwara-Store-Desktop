import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:nwara_store_desktop/core/database/hive/inventory_model.dart';

import '../../../core/database/hive/invoice_model.dart';

part 'add_item_to_invoice_state.dart';

class AddItemToInvoiceCubit extends Cubit<AddItemToInvoiceState> {
  AddItemToInvoiceCubit() : super(AddItemToInvoiceInitial());
  final invoicesBox = Hive.box<InvoiceModel>('invoices');
  final inventoryBox = Hive.box<InventoryModel>('inventory');
  final formKey = GlobalKey<FormState>();
  final quantityController = TextEditingController();
  final sellPriceController = TextEditingController();
  InventoryModel? itemToAddToInvoice;

   addItem({
    required int invoiceId,
    required inventoryItemId,
    //required InvoiceModel invoiceModel ,
   // required InventoryModel itemToAddToInvoice,
    required int quantity,
    //required double sellPrice
  }) async {
    debugPrint("add");
      try {
        emit(AddItemToInvoiceLoading());
        //sellPriceController.text = sellPrice.toString();
        final invoice = invoicesBox.get(invoiceId);
        if (invoice == null) {
          throw Exception("Invoice not found with id $invoiceId");
        }
        final inventoryItem = inventoryBox.get(inventoryItemId);
        if (inventoryItem == null) {
          throw Exception("Inventory item not found with id $inventoryItemId");
        }
        if (inventoryItem.quantity < quantity) {
          throw Exception("Not enough stock for ${inventoryItem.title}");
        }
        inventoryItem.quantity -= quantity;
        await inventoryItem.save();
        // final itemToAddToInvoice = InventoryModel(
        //   id: inventoryItem.id,
        //   title: inventoryItem.title,
        //   purchasedPrice: inventoryItem.purchasedPrice,
        //   sellPrice: sellPrice,
        //   quantity: quantity,
        // );
        itemToAddToInvoice?.sellPrice = double.parse(sellPriceController.text);
        itemToAddToInvoice?.quantity = int.parse(quantityController.text);
        await invoicesBox.put(
            invoiceId,
            InvoiceModel(
              id: invoice.id,
              title: invoice.title,
              date: invoice.date,
              items: [...invoice.items, ?itemToAddToInvoice],
            )
        );

        emit(AddItemToInvoiceSuccess());
      } catch (e) {
        emit(AddItemToInvoiceFailure(e.toString()));
      }
    }

  @override
  Future<void> close() {
    quantityController.dispose();
    sellPriceController.dispose();
    return super.close();
  }
}
