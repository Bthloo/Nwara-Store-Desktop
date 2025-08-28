import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/custom_form_field.dart';
import '../../viewmodel/add_invoice_cubit.dart';
import '../../viewmodel/get_invoices_cubit.dart';

class AddInvoiceDialog extends StatelessWidget {
  const AddInvoiceDialog({super.key,required this.getInvoiceCubit});
final GetInvoicesCubit getInvoiceCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddInvoiceCubit(),
      child: BlocConsumer<AddInvoiceCubit, AddInvoiceState>(
        listener: (context, state) {
          if (state is AddInvoiceSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم اضافة الفاتورة بنجاح"), backgroundColor: Colors.green),
            );
            getInvoiceCubit.getAllInvoices();
          } else if (state is AddInvoiceFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {

          return AlertDialog(
            title: Text("اضافة فاتورة جديدة"),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            content: Form(
              key: context.read<AddInvoiceCubit>().formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomFormField(
                    controller: context.read<AddInvoiceCubit>().invoiceTitleController,
                    hintText: "اسم الفاتورة",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال اسم الفاتورة';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              state is AddInvoiceLoading
                  ? const CircularProgressIndicator() :
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('الغاء', style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                 context.read<AddInvoiceCubit>().addInvoice();
                },
                child: const Text('اضافة'),
              ),
            ],
          );
        },
      ),
    );
  }
}
