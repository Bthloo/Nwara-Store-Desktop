import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../core/database/hive/inventory_model.dart';
import '../../../core/database/hive/invoice_model.dart';

part 'delete_item_from_invoice_state.dart';

class DeleteItemFromInvoiceCubit extends Cubit<DeleteItemFromInvoiceState> {
  DeleteItemFromInvoiceCubit() : super(DeleteItemFromInvoiceInitial());
  final invoicesBox = Hive.box<InvoiceModel>('invoices');
  final inventoryBox = Hive.box<InventoryModel>('inventory');
  deleteItemFromInvoice({
    required String invoiceId,
    required String inventoryItemId,
    required int quantity,
    required int index,
  }) async {
    try {
      emit(DeleteItemFromInvoiceLoading());

      final invoice = invoicesBox.get(invoiceId);
      if (invoice == null) {
        throw Exception("Invoice not found with id $invoiceId");
      }

      if (index < 0 || index >= invoice.items.length) {
        throw Exception("Invalid index $index for invoice items");
      }

      if(invoice.items[index].id.contains("external")){
        invoice.items.removeAt(index);
        await invoice.save();
      }else{
        final inventoryItem = inventoryBox.get(inventoryItemId);
        if (inventoryItem == null) {
          throw Exception("Inventory item not found with id $inventoryItemId");
        }
        inventoryItem.quantity += quantity;
        invoice.items.removeAt(index);
        await invoice.save();
        await inventoryItem.save();
      }



      emit(DeleteItemFromInvoiceSuccess());
    } catch (e) {
      emit(DeleteItemFromInvoiceFailure(e.toString()));
    }
  }
}
