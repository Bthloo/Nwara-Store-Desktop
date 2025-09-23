// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:hive/hive.dart';
// import 'package:meta/meta.dart';
// import 'package:nwara_store_desktop/core/database/hive/inventory_model.dart';
//
// import '../../../core/database/hive/invoice_model.dart';
//
// part 'add_item_to_invoice_state.dart';
//
// class AddItemToInvoiceCubit extends Cubit<AddItemToInvoiceState> {
//   AddItemToInvoiceCubit() : super(AddItemToInvoiceInitial());
//   final invoicesBox = Hive.box<InvoiceModel>('invoices');
//   final inventoryBox = Hive.box<InventoryModel>('inventory');
//   final formKey = GlobalKey<FormState>();
//   final quantityController = TextEditingController();
//   final sellPriceController = TextEditingController();
//   InventoryModel? itemToAddToInvoice;
//
//    addItem({
//     required String invoiceId,
//     required String inventoryItemId,
//     required int quantity,
//   }) async {
//     debugPrint("add");
//       try {
//         emit(AddItemToInvoiceLoading());
//         final invoice = invoicesBox.get(invoiceId);
//         if (invoice == null) {
//           throw Exception("Invoice not found with id $invoiceId");
//         }
//         final inventoryItem = inventoryBox.get(inventoryItemId);
//         if (inventoryItem == null) {
//           throw Exception("Inventory item not found with id $inventoryItemId");
//         }
//         if (inventoryItem.quantity < quantity) {
//           throw Exception("Not enough stock for ${inventoryItem.title}");
//         }
//
//         debugPrint("Before: ${inventoryItem.quantity}");
//         debugPrint("Removing: $quantity");
//         inventoryItem.quantity -= quantity;
//         debugPrint("After: ${inventoryItem.quantity}");
//
//         await inventoryItem.save();
//
//         final inventoryyItem = inventoryBox.get(inventoryItemId);
//         debugPrint("item inventory quantity after save: ${inventoryyItem?.quantity}");
//
//
//         itemToAddToInvoice?.sellPrice = double.parse(sellPriceController.text);
//         itemToAddToInvoice?.quantity = int.parse(quantityController.text);
//         invoice.items.add(itemToAddToInvoice!);
//         debugPrint("item invoice quantity: ${itemToAddToInvoice?.quantity}");
//         debugPrint("item inventory quantity: ${inventoryItem.quantity}");
//         await invoice.save();
//         debugPrint("inventoryItem hashCode: ${inventoryItem.hashCode}");
//         debugPrint("itemToAddToInvoice hashCode: ${itemToAddToInvoice.hashCode}");
//
//         // await invoicesBox.put(
//         //     invoiceId,
//         //     InvoiceModel(
//         //       id: invoice.id,
//         //       title: invoice.title,
//         //       date: invoice.date,
//         //       items: [...invoice.items, ?itemToAddToInvoice],
//         //     )
//         // );
//
//         emit(AddItemToInvoiceSuccess());
//       } catch (e) {
//         emit(AddItemToInvoiceFailure(e.toString()));
//       }
//     }
//
//   @override
//   Future<void> close() {
//     quantityController.dispose();
//     sellPriceController.dispose();
//     return super.close();
//   }
// }







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
  int currentIndex = 0;
  final List<FocusNode> focusNodes = List.generate(2, (_) => FocusNode());
  InventoryModel? itemToAddToInvoice;
  addItem({
    required String invoiceId,
    required String inventoryItemId,
  }) async {
    try {
      emit(AddItemToInvoiceLoading());

      final invoice = invoicesBox.get(invoiceId);
      if (invoice == null) {
        throw Exception("Invoice not found with id $invoiceId");
      }

      final inventoryItem = inventoryBox.get(inventoryItemId);
      if (inventoryItem == null) {
        throw Exception("Inventory item not found with id $inventoryItemId");
      }

      final int quantityToSell = int.parse(quantityController.text);
      final double sellPrice = double.parse(sellPriceController.text);

      if (inventoryItem.quantity < quantityToSell) {
        throw Exception("Not enough stock for ${inventoryItem.title}");
      }

      debugPrint("Inventory before sale: ${inventoryItem.quantity}");
      debugPrint("Quantity to remove: $quantityToSell");

      inventoryItem.quantity -= quantityToSell;
      await inventoryItem.save();
      debugPrint("Inventory after sale: ${inventoryItem.quantity}");


      itemToAddToInvoice = InventoryModel(
        title: inventoryItem.title,
        quantity: quantityToSell,
        sellPrice: sellPrice,
        id: inventoryItem.id,
        purchasedPrice: inventoryItem.purchasedPrice,

      );

      invoice.items.add(itemToAddToInvoice!);
      await invoice.save();

      debugPrint("Invoice item quantity: ${itemToAddToInvoice!.quantity}");
      debugPrint("Inventory quantity: ${inventoryItem.quantity}");
      debugPrint("inventoryItem hashCode: ${inventoryItem.hashCode}");
      debugPrint("invoiceItem hashCode: ${itemToAddToInvoice.hashCode}");

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
