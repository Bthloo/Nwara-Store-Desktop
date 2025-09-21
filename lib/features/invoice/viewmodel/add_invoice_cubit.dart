import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import '../../../core/database/hive/invoice_model.dart';
part 'add_invoice_state.dart';

class AddInvoiceCubit extends Cubit<AddInvoiceState> {
  AddInvoiceCubit() : super(AddInvoiceInitial());
final box = Hive.box<InvoiceModel>('invoices');
final formKey = GlobalKey<FormState>();
final invoiceTitleController = TextEditingController();
  addInvoice() async {
    try {
      emit(AddInvoiceLoading());
      if(!formKey.currentState!.validate()){
        return;
      }
      final newInvoice = InvoiceModel(
        id: "${invoiceTitleController.text}${DateTime.now().millisecondsSinceEpoch}",
        title: invoiceTitleController.text,
        date: DateTime.now(),
        items: [],
      );
     await box.put("${invoiceTitleController.text}${DateTime.now().millisecondsSinceEpoch}", newInvoice);
     emit(AddInvoiceSuccess());
    } catch (e) {
      emit(AddInvoiceFailure(e.toString()));
    }
  }
  @override
  Future<void> close() {
    invoiceTitleController.dispose();
    return super.close();
  }
}
