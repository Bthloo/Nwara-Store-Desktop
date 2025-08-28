import 'package:flutter/cupertino.dart';
import '../../../../core/database/hive/invoice_model.dart';
import '../../viewmodel/get_invoices_cubit.dart';
import 'invoice_table_body.dart';
import 'invoice_table_header.dart';

class InvoiceTable extends StatelessWidget {
   final List<InvoiceModel> items;
   final GetInvoicesCubit getInvoicesCubit;
  const InvoiceTable({super.key, required this.items, required this.getInvoicesCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         InvoiceTableHeader(),
        InvoiceTableBody(items: items, getCubit: getInvoicesCubit),
      ],
    );
  }
}
