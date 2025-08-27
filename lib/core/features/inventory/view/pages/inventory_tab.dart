import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/color_helper.dart';
import 'package:nwara_store_desktop/core/components/custom_form_field.dart';
import 'package:nwara_store_desktop/core/features/inventory/viewmodel/add_inventory_item_cubit.dart';
import 'package:nwara_store_desktop/core/features/inventory/viewmodel/get_inventory_items_cubit.dart';
import '../../../home/view/components/invoice_row_cell.dart';
import '../../../home/view/components/table_header.dart';

class InventoryTab extends StatelessWidget {
  const InventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => GetInventoryItemsCubit()..getAllInventoryItems(),
  child: Builder(
    builder: (context) {
      final getCubit = context.read<GetInventoryItemsCubit>();
      return Scaffold(
          appBar: AppBar(title: const Text("المخزن"), centerTitle: false),
          bottomNavigationBar: BottomAppBar(
            color: ColorHelper.darkColor,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {

                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (dialogContext) {
                        return BlocProvider(
                          create: (context) => AddInventoryItemCubit(),
                          child:
                              BlocConsumer<
                                AddInventoryItemCubit,
                                AddInventoryItemState
                              >(
                                listener: (dialogContext, state) {
                                  if (state is AddInventoryItemSuccess) {

                                    Navigator.of(dialogContext).pop();
                                    getCubit.getAllInventoryItems();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("تم اضافة المنتج بنجاح"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );

                                  } else if (state is AddInventoryItemFailure) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.errorMessage),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, addInventoryItemState) {
                                  final cubit = context.read<AddInventoryItemCubit>();
                                  return AlertDialog(
                                    title: const Text('اضافة منتج جديد'),
                                    content: Form(
                                      key: cubit.formKey,
                                      child: Column(
                                        spacing: 10,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomFormField(
                                            hintText: "اسم المنتج",
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'الرجاء ادخال اسم المنتج';
                                              }
                                              return null;
                                            },
                                            controller: cubit.titleController,
                                          ),
                                          CustomFormField(
                                            hintText: "الكمية",
                                            validator: (value) {
                                              final regex = RegExp(r'^\d+(\.\d+)?$');
                                              if (value == null || value.isEmpty) {
                                                return 'الرجاء ادخال الكمية';
                                              }
                                              if (int.tryParse(value) == null) {
                                                return 'الرجاء ادخال رقم صحيح';
                                              }
                                              if(!regex.hasMatch(value)){
                                                return 'الرجاء ادخال رقم صحيح';
                                              }
                                              if(value.contains('.')){
                                                return 'الرجاء ادخال رقم صحيح';
                                              }
                                              return null;
                                            },
                                            controller: cubit.quantityController,
                                          ),
                                          CustomFormField(
                                            hintText: "سعر الشراء",
                                            validator: (value) {
                                              final regex = RegExp(r'^\d+(\.\d+)?$');
                                              if (value == null || value.isEmpty) {
                                                return 'الرجاء ادخال سعر الشراء';
                                              }
                                              if (int.tryParse(value) == null) {
                                                return 'الرجاء ادخال رقم صحيح';
                                              }
                                              if(!regex.hasMatch(value)){
                                                return 'الرجاء ادخال رقم صحيح';
                                              }
                                              return null;
                                            },
                                            controller:
                                                cubit.purchasedPriceController,
                                          ),
                                          CustomFormField(
                                            hintText: "سعر البيع",
                                            validator: (value) {
                                              final regex = RegExp(r'^\d+(\.\d+)?$');
                                              if (value == null || value.isEmpty) {
                                                return 'الرجاء ادخال سعر البيع';
                                              }
                                              if (int.tryParse(value) == null) {
                                                return 'الرجاء ادخال رقم صحيح';
                                              }
                                              if(!regex.hasMatch(value)){
                                                return 'الرجاء ادخال رقم صحيح';
                                              }
                                              return null;
                                            },
                                            controller:
                                                cubit.sellingPriceController,
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [

                                      if (addInventoryItemState
                                          is AddInventoryItemLoading)
                                        const CircularProgressIndicator()
                                      else
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'الغاء',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            cubit.addItem();
                                          },
                                          child: const Text('اضافه'),
                                        ),
                                    ],
                                  );
                                },
                              ),
                        );
                      },
                    );
                  },
                  child: const Text("اضافة منتج جديد"),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<GetInventoryItemsCubit, GetInventoryItemsState>(
              builder: (context, getInventoryItemsState) {
                if (getInventoryItemsState is GetInventoryItemsLoading) {
                  return const Center(child: CupertinoActivityIndicator());
                } else if (getInventoryItemsState is GetInventoryItemsFailure) {
                  return Center(
                    child: Text(
                      getInventoryItemsState.errorMessage,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (getInventoryItemsState is GetInventoryItemsSuccess) {
                  final items = getInventoryItemsState.items;
                  if (items.isEmpty) {
                    return const Center(child: Text("لا يوجد منتجات في المخزن"));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Table(
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  border: Border.all(),
                                  color: const Color(0xFF1C2126),
                                ),
                                children: const [
                                  InvoiceHeaderCell(text: "اسم المنتج",),
                                  InvoiceHeaderCell(text: "الكمية"),
                                  InvoiceHeaderCell(text: "سعر الشراء",),
                                  InvoiceHeaderCell(text: "سعر البيع المبدئي",),
                                  InvoiceHeaderCell(text: "صافي الربح المتوقع",),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              border: Border(
                                right: BorderSide(color: Colors.white),
                                left: BorderSide(color: Colors.white),
                                bottom: BorderSide(color: Colors.white),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(8),
                              ),
                              child: SingleChildScrollView(
                                child: Table(
                                  children: List.generate(
                                    items.length,
                                    (index) => TableRow(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                            width: index == 0 ? 0 : 1,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      children: [
                                        InvoiceRowCell(
                                            text: items[index].title,
                                          isNumber: false,
                                          title: items[index].title,
                                          purchasedPrice: items[index].purchasedPrice,
                                          quantity: items[index].quantity,
                                          sellPrice: items[index].sellPrice,
                                          id: items[index].id,
                                          getItemCubit: getCubit,
                                        ),
                                        InvoiceRowCell(
                                          text: items[index].quantity.toString(),
                                          isNumber: true,
                                          title: items[index].title,
                                          purchasedPrice: items[index].purchasedPrice,
                                          quantity: items[index].quantity,
                                          sellPrice: items[index].sellPrice,
                                          id: items[index].id,
                                          getItemCubit: getCubit,
                                        ),
                                        InvoiceRowCell(
                                          text: items[index].purchasedPrice
                                              .toString(),
                                          isNumber: true,
                                          title: items[index].title,
                                          purchasedPrice: items[index].purchasedPrice,
                                          quantity: items[index].quantity,
                                          sellPrice: items[index].sellPrice,
                                          id: items[index].id,
                                          getItemCubit: getCubit,
                                        ),
                                        InvoiceRowCell(
                                          text: items[index].sellPrice
                                              .toString(),
                                          isNumber: true,
                                          title: items[index].title,
                                          purchasedPrice: items[index].purchasedPrice,
                                          quantity: items[index].quantity,
                                          sellPrice: items[index].sellPrice,
                                          id: items[index].id,
                                          getItemCubit: getCubit,
                                        ),
                                        InvoiceRowCell(
                                          text:
                                              (items[index].sellPrice - items[index].purchasedPrice
                                                      )
                                                  .toString(),
                                          isNumber: true,
                                          title: items[index].title,
                                          purchasedPrice: items[index].purchasedPrice,
                                          quantity: items[index].quantity,
                                          sellPrice: items[index].sellPrice,
                                          id: items[index].id,
                                          getItemCubit: getCubit,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return Center(
                    child: Text(
                      "حدث خطأ غير معروف",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
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
