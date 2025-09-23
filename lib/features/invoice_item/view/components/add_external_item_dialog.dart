import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/custom_form_field.dart';
import 'package:nwara_store_desktop/features/invoice_item/viewmodel/add_extermal_item_cubit.dart';

class AddExternalItemDialog extends StatelessWidget {
  const AddExternalItemDialog({super.key, required this.invoiceId});
final String invoiceId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddExternalItemCubit(),
      child: BlocConsumer<AddExternalItemCubit, AddExternalItemState>(
        listener: (context, state) {
          if (state is AddExternalItemSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم اضافة الصنف الخارجي بنجاح"), backgroundColor: Colors.green),
            );
          } else if (state is AddExternalItemFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },

        builder:(context, state) {
          final cubit = context.read<AddExternalItemCubit>();
          return AlertDialog(
            title: Text("اضافة صنف خارجي"),
            content: Form(
              key: context.read<AddExternalItemCubit>().formKey,
              child: Focus(
                onKeyEvent: (node, event) {
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
                  } else
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.enter) {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.addExternalItem(invoiceId: invoiceId);
                        return KeyEventResult.handled;
                      }

                    }
                  }
                  return KeyEventResult.ignored;
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    CustomFormField(
                      focus: true,
                        focusNode: cubit.focusNodes[0],
                        onTap: () => cubit.currentIndex = 0,
                        hintText: 'الاسم',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'الرجاء ادخال الاسم';
                          }
                          return null;
                        },
                        controller: context.read<AddExternalItemCubit>().itemNameController
                    ),
                    CustomFormField(
                        focusNode: cubit.focusNodes[1],
                        onTap: () => cubit.currentIndex = 1,
                        hintText: 'السعر',
                        validator: (value) {
                          final regex = RegExp(r'^\d+(\.\d+)?$');
                          if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال السعر';
                          }
                          if (!regex.hasMatch(value)) {
                            return 'الرجاء ادخال رقم صحيح';
                          }
                          return null;
                        },
                        controller: context.read<AddExternalItemCubit>().priceController
                    )
                  ],
                ),
              ),
            ),
            actions:
            state is AddExternalItemLoading
                ? [CircularProgressIndicator()]  :
            [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("إلغاء"),
              ),
              TextButton(
                onPressed: () {
                  context.read<AddExternalItemCubit>().addExternalItem(invoiceId: invoiceId);
                },
                child: Text("إضافة"),
              ),
            ],
          );
        },
      ),
    );
  }
}
