import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/custom_form_field.dart';
import 'package:nwara_store_desktop/core/database/hive/inventory_model.dart';
import 'package:nwara_store_desktop/features/inventory/viewmodel/get_inventory_items_cubit.dart';
import 'package:nwara_store_desktop/features/invoice_item/viewmodel/add_item_to_invoice_cubit.dart';

import 'custom_drop_down_search.dart';

class AddItemFromInventoryDialog extends StatelessWidget {
  const AddItemFromInventoryDialog({super.key,required this.invoiceId});
final String invoiceId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetInventoryItemsCubit()..getAllInventoryItems(),
      child: BlocBuilder<GetInventoryItemsCubit, GetInventoryItemsState>(
        builder: (context, state) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("اضافة عنصر من المخزن", style: TextStyle(fontSize: 30)),
                  SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      if (state is GetInventoryItemsLoading) {
                        return CircularProgressIndicator();
                      } else if (state is GetInventoryItemsFailure) {
                        return Column(
                          children: [
                            Text(
                              state.errorMessage,
                              style: TextStyle(color: Colors.red),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<GetInventoryItemsCubit>()
                                    .getAllInventoryItems();
                              },
                              child: Text("اعادة المحاولة"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("الغاء"),
                            ),
                          ],
                        );
                      } else if (state is GetInventoryItemsSuccess) {
                        if (state.items.isEmpty) {
                          return Column(
                                children: [
                                  Text("لا يوجد عناصر في المخزن"),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("الغاء"),
                                  ),
                                ],
                              );

                        } else {
                          return BlocProvider(
                            create: (context) => AddItemToInvoiceCubit(),
                            child: BlocConsumer<AddItemToInvoiceCubit, AddItemToInvoiceState>(
                              listener: (context, state) {
                                if (state is AddItemToInvoiceSuccess) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("تمت إضافة العنصر بنجاح")),
                                  );
                                } else if (state is AddItemToInvoiceFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.errorMessage)),
                                  );
                                }
                              },
                              builder: (context, addItemState) {
                                final addCubit = context.read<AddItemToInvoiceCubit>();
                                return Form(
                                  key: addCubit.formKey,
                                  child: Column(
                                    spacing: 10,
                                    children: [
                                      CustomDropDownSearch(
                                        addCubit: addCubit,
                                        items: state.items,
                                      ),

                                      CustomFormField(
                                        hintText: "الكمية",
                                        onChange: (value) {
                                         // addCubit.quantityController.text = value ?? "";
                                        },
                                        validator: (value) {
                                          final regex = RegExp(r'^\d+(\.\d+)?$');
                                          if (value == null || value.isEmpty) {
                                            return 'الرجاء ادخال الكمية';
                                          }
                                          if(!regex.hasMatch(value)){
                                            return 'الرجاء ادخال رقم صحيح';
                                          }
                                          if(value.contains('.')){
                                            return 'الرجاء ادخال رقم صحيح';
                                          }
                                          if(int.parse(value) > addCubit.itemToAddToInvoice!.quantity){
                                            return "الكمية المتوفرة في المخزن هي ${addCubit.itemToAddToInvoice?.quantity}";
                                          }
                                          return null;
                                        },
                                        controller: addCubit.quantityController,
                                      ),
                                      CustomFormField(
                                        hintText: "سعر البيع",
                                        validator: (value) {
                                          final regex = RegExp(r'^\d+(\.\d+)?$');
                                          if (value == null || value.isEmpty) {
                                            return 'الرجاء ادخال سعر البيع';
                                          }
                                          if(!regex.hasMatch(value)){
                                            return 'الرجاء ادخال رقم صحيح';
                                          }
                                          return null;
                                        },
                                        controller: addCubit.sellPriceController,
                                      ),
                                      SizedBox(height: 20),
                                      if (addItemState is AddItemToInvoiceLoading)
                                        CircularProgressIndicator()
                                      else
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("الغاء"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                               debugPrint("sell price: ${addCubit.sellPriceController.text}");
                                                if (!addCubit.formKey.currentState!.validate()) {

                                                  return;
                                                }
                                                addCubit.addItem(
                                                    invoiceId: invoiceId,
                                                    inventoryItemId: addCubit.itemToAddToInvoice!.key,
                                                    //quantity: int.parse(addCubit.quantityController.text),
                                                  //  sellPrice: double.parse(addCubit.sellPriceController.text)
                                                );
                                              },
                                              child: Text("اضافة"),
                                            ),

                                    ],
                                            )] ),
                                );
                              },
                            ),
                          );
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
