import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../core/database/hive/inventory_model.dart';
import '../../../core/database/hive/invoice_model.dart';
import '../view/pages/invoice_item.dart';

part 'add_extermal_item_state.dart';

class AddExternalItemCubit extends Cubit<AddExternalItemState> {
  AddExternalItemCubit() : super(AddExternalItemInitial());
  final TextEditingController itemNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final invoicesBox = Hive.box<InvoiceModel>('invoices');

  void addExternalItem({required String invoiceId}) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      try {
        emit(AddExternalItemLoading());
        final invoice = invoicesBox.get(invoiceId);
        if (invoice == null) {
          throw Exception("Invoice not found with id $invoiceId");
        }
        final double price = double.parse(priceController.text);

        var externalItem = InventoryModel(
          id: "external${itemNameController.text}${DateTime.now().millisecondsSinceEpoch}",
          title: itemNameController.text,
          quantity: 1,
          sellPrice: -1 * price,
          purchasedPrice: 0,
        );
        invoice.items.add(externalItem);
        await invoice.save();
        emit(AddExternalItemSuccess());
      } catch (e) {
        emit(AddExternalItemFailure(e.toString()));
      }
    }
  }
}
