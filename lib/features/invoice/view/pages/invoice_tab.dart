import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/color_helper.dart';
import '../../viewmodel/get_invoices_cubit.dart';
import '../components/add_invoice_dialog.dart';
import '../components/invoice_table.dart';

class InvoiceTab extends StatelessWidget {
  const InvoiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      GetInvoicesCubit()
        ..getAllInvoices(),
      child:  Builder(
        builder: (context) {
          final getInvoicesCubit = context.read<GetInvoicesCubit>();
          return Scaffold(
                bottomNavigationBar: BottomAppBar(
                  color: ColorHelper.darkColor,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (dialogContext) {
                              return AddInvoiceDialog(getInvoiceCubit:getInvoicesCubit);
                            },
                          );
                        },
                        child: const Text("اضافة فاتورة جديدة"),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(
                  title: const Text("الفواتير"),
                  centerTitle: false,
                ),
                body: Padding(padding: EdgeInsets.all(10),
                    child: BlocBuilder<GetInvoicesCubit, GetInvoicesState>(
                      builder: (context, state) {
                        if(state is GetInvoicesLoading){
                          return const Center(child: CupertinoActivityIndicator());
                        } else if(state is GetInvoicesFailure){
                          return Center(child: Text(state.errorMessage, style: const TextStyle(color: Colors.red),),);
                        } else if(state is GetInvoicesSuccess){
                          final invoices = state.invoices;
                          if(invoices.isEmpty){
                            return const Center(child: Text("لا يوجد فواتير"),);
                          } else {
                            return InvoiceTable(
                              items: invoices,
                              getInvoicesCubit: getInvoicesCubit,
                            );
                          }
                        } else {
                          return Center(child: Text("حدث خطأ غير معروف"),);
                        }
                      },
                    )),
              );
        }
      )
    );
  }
}
