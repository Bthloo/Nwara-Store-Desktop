import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_form_field.dart';
import '../../viewmodel/get_profit_share_cubit.dart';
import '../../viewmodel/share_profit_cubit.dart';

class AddProfitShareDialog extends StatelessWidget {
  const AddProfitShareDialog({super.key,required this.remainingProfit});
final double remainingProfit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShareProfitCubit(),
      child: BlocConsumer<ShareProfitCubit, ShareProfitState>(
        listener: (context, state) {
          if(state is ShareProfitSuccess){
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم تقسيم الارباح بنجاح"), backgroundColor: Colors.green),
            );
          } else if(state is ShareProfitFailure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: Text("تقسيم الارباح"),
            content: Form(
              key: context.read<ShareProfitCubit>().formKey,
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomFormField(
                    hintText: "الاسم",
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'الرجاء ادخال الاسم';
                      }
                      return null;
                    },
                    controller: context.read<ShareProfitCubit>().nameController,
                  ),
                  CustomFormField(
                    hintText: "المبلغ",
                    validator: (value) {
                      final regex = RegExp(r'^\d+(\.\d+)?$');
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال المبلغ';
                      }
                      if (!regex.hasMatch(value)) {
                        return 'الرجاء ادخال رقم صحيح';
                      }
                      if(double.parse(value) > remainingProfit){
                        return 'المبلغ اكبر من المتبقي $remainingProfit';
                      }
                      return null;
                    },
                    controller: context.read<ShareProfitCubit>().amountController,
                  ),
                ],
              ),
            ),
            actions:
            state is ShareProfitLoading ? [CircularProgressIndicator()] :
            [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("الغاء"),
              ),
              TextButton(
                onPressed: () {
                  context.read<ShareProfitCubit>().shareProfit();
                },
                child: Text("تأكيد"),
              ),
            ],
          );
        },
      ),
    );
  }
}
