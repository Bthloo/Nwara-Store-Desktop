import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/color_helper.dart';
import 'package:nwara_store_desktop/features/invoice_item/view/components/invoice_table.dart';
import 'package:nwara_store_desktop/features/invoice_item/viewmodel/get_invoive_cubit.dart';

import '../components/add_item_from_inventory_dialog.dart';
import '../components/custom_expantion.dart';

class InvoiceItem extends StatelessWidget {
  const InvoiceItem({super.key});
static const String routeName = "invoice_item";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    debugPrint(id.toString());
    return BlocProvider(
  create: (context) => GetInvoiceCubit()..getInvoiceById(id),
  child: Builder(
    builder: (context) {
      final getInvoiceCubit = context.read<GetInvoiceCubit>();
      return Scaffold(
          bottomNavigationBar: BottomAppBar(
            color: ColorHelper.darkColor,
            child: Row(
              spacing: 20,
              children: [
                ElevatedButton(
                    onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AddItemFromInventoryDialog(invoiceId: id);
                      },
                  ).then((value) {
                      getInvoiceCubit.getInvoiceById(id);
                  },);
                }, child: Text("اضافة منتج من المخزن")),

                ElevatedButton(
                    onPressed: () {

                }, child: Text("اضافة منتج خارجي")),
              ],
            ),
          ),
          appBar: AppBar(title: const Text("عنصر الفاتورة"), centerTitle: false),
          body:  Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<GetInvoiceCubit, GetInvoiceState>(
  builder: (context, state) {
    if(state is GetInvoiceLoading){
      return const Center(child: CircularProgressIndicator());
    } else if(state is GetInvoiceFailure){
      return Center(child: Text(state.errorMessage, style: const TextStyle(color: Colors.red),),);
    } else if(state is GetInvoiceSuccess){
      if(state.item.items.isEmpty){
        return const Center(child: Text("لا يوجد عناصر في الفاتورة"),);
      }else{
        return Row(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width*0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تفاصيل الفاتورة",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomExpantion(
                    netProfit: getInvoiceCubit.netProfit,
                    totalPurchasePrice: getInvoiceCubit.purchasedPrice,
                    totalSellPrice: getInvoiceCubit.sellPrice,
                  ),
                ],
              ),
            ),
            Expanded(
                child: InvoiceItemTable(
                    items: state.item.items,
                    getInvoiceCubit: getInvoiceCubit
                )
            ),
          ],
        );
      }
    }else{
      return const Center(child: Text("حدث خطأ غير معروف"),);
    }
  },
),
          ),
        );
    }
  ),
);
  }
}
