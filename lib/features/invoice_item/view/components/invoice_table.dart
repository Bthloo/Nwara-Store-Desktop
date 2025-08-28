
import 'package:flutter/cupertino.dart';
import 'package:nwara_store_desktop/features/invoice_item/viewmodel/get_invoive_cubit.dart';

import '../../../../core/database/hive/inventory_model.dart';
import '../../../inventory/view/components/inventory_table_header.dart';
import 'invoice_item_table_body.dart';
import 'invoice_item_table_header.dart';

class InvoiceItemTable extends StatelessWidget {
  final List<InventoryModel> items;
  final GetInvoiceCubit getInvoiceCubit;

  const InvoiceItemTable({super.key, required this.items, required this.getInvoiceCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InvoiceItemTableHeader(),
        InvoiceItemTableBody(items: items, getInvoiceCubit: getInvoiceCubit,),
      ],
    );
  }
}