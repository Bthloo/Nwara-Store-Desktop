import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import '../../../core/database/hive/invoice_model.dart';
part 'delete_invoice_state.dart';

class DeleteInvoiceCubit extends Cubit<DeleteInvoiceState> {
  DeleteInvoiceCubit() : super(DeleteInvoiceInitial());
  final box = Hive.box<InvoiceModel>('invoices');
  void deleteInvoice(String id) async {
    try {
      emit(DeleteInvoiceLoading());
  //    final invoiceToDelete = box.values.firstWhere((invoice) => invoice.id == id);
      await box.delete(id);
     // invoiceToDelete.delete();
      emit(DeleteInvoiceSuccess());
    } catch (e) {
      emit(DeleteInvoiceFailure(e.toString()));
    }
  }
}
