import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:nwara_store_desktop/core/database/hive/invoice_model.dart';

part 'get_invoices_state.dart';

class GetInvoicesCubit extends Cubit<GetInvoicesState> {
  GetInvoicesCubit() : super(GetInvoicesInitial());
  final box = Hive.box<InvoiceModel>('invoices');
  getAllInvoices() async {
    try {
      emit(GetInvoicesLoading());
      final invoices = box.values.toList();
      emit(GetInvoicesSuccess(invoices));
    } catch (e) {
      emit(GetInvoicesFailure(e.toString()));
    }
  }
}
