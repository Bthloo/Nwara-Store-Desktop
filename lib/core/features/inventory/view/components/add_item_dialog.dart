import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/custom_form_field.dart';
import '../../viewmodel/add_inventory_item_cubit.dart';
import '../../viewmodel/get_inventory_items_cubit.dart';

class AddInventoryItemDialog extends StatelessWidget {
  final GetInventoryItemsCubit getCubit;

  const AddInventoryItemDialog({super.key, required this.getCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddInventoryItemCubit(),
      child: BlocConsumer<AddInventoryItemCubit, AddInventoryItemState>(
        listener: (context, state) {
          if (state is AddInventoryItemSuccess) {
            Navigator.of(context).pop();
            getCubit.getAllInventoryItems();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم اضافة المنتج بنجاح"), backgroundColor: Colors.green),
            );
          } else if (state is AddInventoryItemFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<AddInventoryItemCubit>();
          return AlertDialog(
            title: const Text('اضافة منتج جديد'),
            content: Form(
              key: cubit.formKey,
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
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
              if (state is AddInventoryItemLoading)
                const CircularProgressIndicator()
              else
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('الغاء', style: TextStyle(color: Colors.red)),
                ),
              TextButton(
                onPressed: () => cubit.addItem(),
                child: const Text('اضافه'),
              ),
            ],
          );
        },
      ),
    );
  }
}
