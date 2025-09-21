import 'package:flutter/material.dart';
import 'package:nwara_store_desktop/features/invoice/view/components/spoiler_cell.dart';
import 'package:nwara_store_desktop/features/invoice/view/components/time_dialog.dart';
import '../../../../core/database/hive/invoice_model.dart';
import '../../../invoice_item/view/pages/invoice_item.dart';
import '../../viewmodel/get_invoices_cubit.dart';
import 'invoice_row_cell.dart';

class InvoiceTableBody extends StatelessWidget {
  final List<InvoiceModel> items;
  final GetInvoicesCubit getCubit;
  const InvoiceTableBody({super.key,required this.items, required this.getCubit});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          border: Border(left: BorderSide(color: Color(0xFF9CABBA)), right: BorderSide(color:  Color(0xFF9CABBA)), bottom: BorderSide(color:  Color(0xFF9CABBA))),
        ),
        child: SingleChildScrollView(
          child: Table(
            children: List.generate(
              items.length,
                  (index) => TableRow(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color:  Color(0xFF9CABBA), width: index == 0 ? 0 : 1)),
                ),
                children: [
                  InvoiceRowCell(
                    text: items[index].title,
                    isNumber: false,
                    onTap: () {
                      Navigator.of(context).pushNamed(InvoiceItem.routeName,arguments: items[index].key).then((value) {
                        getCubit.getAllInvoices();
                      },);
                    },
                  ),
                  InvoiceRowCell(
                    text: "${items[index].date.day}/${items[index].date.month}/${items[index].date.year} - ${items[index].date.hour}:${items[index].date.minute}" ,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return TimeDialog(dateTime: items[index].date,);
                          },
                      );
                    },
                  ),
                  InvoiceRowCell(
                    text: items[index].items.length.toString(),
                    onTap: () {

                    },
                  ),
                  SpoilerCell(
                      text: items[index].items.isEmpty ? "0" :
                      items[index].items.map((e) =>
                      (e.sellPrice - e.purchasedPrice) * e.quantity)
                          .reduce((value, element) => value + element).toString(),
                  ),
                  InvoiceRowCell(
                    text:"غير مكتملة" ,
                    isNumber: false,
                    onTap: () {

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
