import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:nwara_store_desktop/core/database/hive/invoice_model.dart';

part 'get_invoive_state.dart';

class GetInvoiceCubit extends Cubit<GetInvoiceState> {
  GetInvoiceCubit() : super(GetInvoiceInitial());
  final box = Hive.box<InvoiceModel>('invoices');
  double purchasedPrice = 0.0;
  double sellPrice = 0.0;
  double netProfit = 0.0;
  getInvoiceById(String id) async {
    try {
      emit(GetInvoiceLoading());
      final invoice = box.get(id);
      if (invoice == null) {
        throw Exception("Invoice not found with id $id");
      }
      if(invoice.items.isEmpty){
         purchasedPrice = 0.0;
         sellPrice = 0.0;
         netProfit = 0.0;
      }
      purchasedPrice = invoice.items.fold(0.0, (sum, item) => sum + (item.purchasedPrice * item.quantity));
      sellPrice = invoice.items.fold(0.0, (sum, item) => sum + (item.sellPrice * item.quantity));
      netProfit = sellPrice - purchasedPrice;
      emit(GetInvoiceSuccess(invoice));
    } catch (e) {
      emit(GetInvoiceFailure(e.toString()));
    }
  }
}
