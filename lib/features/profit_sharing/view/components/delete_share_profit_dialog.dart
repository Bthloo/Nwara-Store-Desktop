import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/features/profit_sharing/viewmodel/delete_share_profit_cubit.dart';

class DeleteShareProfitDialog extends StatelessWidget {
  const DeleteShareProfitDialog({super.key, required this.name,required this.itemKey});

  final String name;
  final dynamic itemKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteShareProfitCubit(),
      child: BlocConsumer<DeleteShareProfitCubit, DeleteShareProfitState>(
        listener: (context, state) {
          if (state is DeleteShareProfitSuccess) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("تم حذف تقسيم الارباح بنجاح"), backgroundColor: Colors.green),
            );
          } else if (state is DeleteShareProfitFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: Text("حذف تقسيم الارباح"),
            content: Text("هل انت متأكد من حذف $name؟"),
            actions:
                state is DeleteShareProfitLoading
                    ? [const CircularProgressIndicator()]
                    :
            [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("لا"),
              ),
              TextButton(
                onPressed: () {
                  context.read<DeleteShareProfitCubit>().deleteProfitShare(itemKey);
                },
                child: Text("نعم",style: TextStyle(
                  color: Colors.red
                ),),
              ),
            ],
          );
        },
      ),
    );
  }
}
