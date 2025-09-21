import 'package:flutter/material.dart';
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
          return AlertDialog(
            title: Text("اضافة صنف خارجي"),
            content: Form(
              key: context.read<AddExternalItemCubit>().formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  CustomFormField(
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
