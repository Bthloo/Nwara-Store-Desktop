import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          cubit.initValues(
            quantity: quantity,
            purchasedPrice: purchasedPrice,
            sellPrice: sellPrice,
          );

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
              child: Focus(
                focusNode: FocusNode(),
                onKeyEvent: (node, event) {
                  if (event is KeyDownEvent) {
                    final currentIndex = cubit.focusNodes.indexWhere((f) => f.hasFocus);

                    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                      if (currentIndex < cubit.focusNodes.length - 1) {
                        cubit.focusNodes[currentIndex + 1].requestFocus();
                      }
                      return KeyEventResult.handled;
                    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                      if (currentIndex > 0) {
                        cubit.focusNodes[currentIndex - 1].requestFocus();
                      }
                      return KeyEventResult.handled;
                    } else if (event.logicalKey == LogicalKeyboardKey.enter) {

                      cubit.editInventoryItem(
                        id: id,
                        title: title,
                        // newQuantity: int.parse(
                        //   cubit.quantityController.text,
                        // ),
                        // newPurchasedPrice: double.parse(
                        //   cubit.purchasedPriceController.text,
                        // ),
                        // newSellPrice: double.parse(
                        //   cubit.sellingPriceController.text,
                        // ),
                      );

                      return KeyEventResult.handled;
                    }
                  }
                  return KeyEventResult.ignored;
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    CustomFormField(
                      focus: true,
                      focusNode: cubit.focusNodes[0],
                      onTap: () => cubit.currentIndex = 0,
                      hintText: 'الكمية',
                      validator: (value) {
                        final regex = RegExp(r'^\d+(\.\d+)?$');
                        if (value == null || value.trim().isEmpty) {
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
                      focusNode: cubit.focusNodes[1],
                      onTap: () => cubit.currentIndex = 1,
                      hintText: 'سعر الشراء',
                      validator: (value) {
                        final regex = RegExp(r'^\d+(\.\d+)?$');
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال سعر الشراء';
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
                      focusNode: cubit.focusNodes[2],
                      onTap: () => cubit.currentIndex = 2,
                      hintText: 'سعر البيع',
                      validator: (value) {
                        final regex = RegExp(r'^\d+(\.\d+)?$');
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال سعر البيع';
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

          if(!cubit.formKey.currentState!.validate()){
          return;
          }

                  cubit.editInventoryItem(
                    id: id,
                    title: title,
                    // newQuantity: int.parse(
                    //   cubit.quantityController.text,
                    // ),
                    // newPurchasedPrice: double.parse(
                    //   cubit.purchasedPriceController.text,
                    // ),
                    // newSellPrice: double.parse(
                    //   cubit.sellingPriceController.text,
                    // ),
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
