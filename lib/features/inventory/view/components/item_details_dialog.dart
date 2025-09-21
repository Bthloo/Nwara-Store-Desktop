import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/custom_form_field.dart';
import '../../viewmodel/delete_inventory_item_cubit.dart';
import '../../viewmodel/edit_inventory_item_cubit.dart';
import '../../viewmodel/get_inventory_items_cubit.dart';

class ItemDetailsDialog extends StatelessWidget {
  final String title;
  final double purchasedPrice;
  final int quantity;
  final double sellPrice;
  final String id;
  final GetInventoryItemsCubit getItemCubit;
  const ItemDetailsDialog({
    super.key,
    required this.title,
    required this.purchasedPrice,
    required this.quantity,
    required this.sellPrice,
    required this.id,
    required this.getItemCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditInventoryItemCubit(),
      child: BlocConsumer<EditInventoryItemCubit, EditInventoryItemState>(
        listener: (context, state) {
          if (state is EditInventoryItemSuccess) {
            Navigator.of(context).pop();
            getItemCubit.getAllInventoryItems();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('تم تعديل المنتج بنجاح')),
            );
          } else if (state is EditInventoryItemFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<EditInventoryItemCubit>();
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceBetween,
            title: Text(
              title,
              style: TextStyle(fontSize: 35, color: Colors.white),
            ),
            icon: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'هل أنت متأكد من حذف هذا المنتج $title؟',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'إلغاء',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      BlocProvider(
                        create: (context) =>
                            DeleteInventoryItemCubit(),
                        child:
                        BlocConsumer<
                            DeleteInventoryItemCubit,
                            DeleteInventoryItemState
                        >(
                          listener: (context, state) {
                            if (state is DeleteInventoryItemSuccess) {
                              Navigator.of(context).pop();
                              getItemCubit.getAllInventoryItems();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('تم حذف المنتج بنجاح')),
                              );
                            } else if (state
                            is DeleteInventoryItemFailure) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content:
                                  Text(state.errorMessage),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return TextButton(
                              onPressed: () {
                                context
                                    .read<DeleteInventoryItemCubit>()
                                    .deleteInventoryItem(id);
                              },
                              child: const Text(
                                'مسح',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              label: Text("مسح", style: TextStyle(color: Colors.red)),
              icon: Icon(Icons.delete, color: Colors.red),
            ),
            content: Form(
              key: cubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  CustomFormField(
                    hintText: 'الكمية',
                    validator: (value) {
                      final regex = RegExp(r'^\d+(\.\d+)?$');
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال الكمية';
                      }
                      if (int.tryParse(value) == null) {
                        return 'الرجاء ادخال رقم صحيح';
                      }
                      if (!regex.hasMatch(value)) {
                        return 'الرجاء ادخال رقم صحيح';
                      }
                      if (value.contains('.')) {
                        return 'الرجاء ادخال رقم صحيح';
                      }
                      return null;
                    },
                    controller: cubit.quantityController
                      ..text = quantity.toString(),
                  ),
                  CustomFormField(
                    hintText: 'سعر الشراء',
                    validator: (value) {
                      final regex = RegExp(r'^\d+(\.\d+)?$');
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال سعر الشراء';
                      }
                      if (int.tryParse(value) == null) {
                        return 'الرجاء ادخال رقم صحيح';
                      }
                      if (!regex.hasMatch(value)) {
                        return 'الرجاء ادخال رقم صحيح';
                      }
                      return null;
                    },
                    controller: cubit.purchasedPriceController
                      ..text = purchasedPrice.toString(),
                  ),
                  CustomFormField(
                    hintText: 'سعر البيع',
                    validator: (value) {
                      final regex = RegExp(r'^\d+(\.\d+)?$');
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال سعر البيع';
                      }
                      if (int.tryParse(value) == null) {
                        return 'الرجاء ادخال رقم صحيح';
                      }
                      if (!regex.hasMatch(value)) {
                        return 'الرجاء ادخال رقم صحيح';
                      }
                      return null;
                    },
                    controller: cubit.sellingPriceController
                      ..text = sellPrice.toString(),
                  ),
                ],
              ),
            ),
            actions: [
              if (state is EditInventoryItemLoading)
                const CircularProgressIndicator()
              else
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'إلغاء',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              TextButton(
                onPressed: () {
                  cubit.editInventoryItem(
                    id: id,
                    title: title,
                    newQuantity: int.parse(
                      cubit.quantityController.text,
                    ),
                    newPurchasedPrice: double.parse(
                      cubit.purchasedPriceController.text,
                    ),
                    newSellPrice: double.parse(
                      cubit.sellingPriceController.text,
                    ),
                  );
                },
                child: const Text('حفظ'),
              ),
            ],
          );
        },
      ),
    );
  }
}
