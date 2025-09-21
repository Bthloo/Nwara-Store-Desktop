import 'package:flutter/material.dart';
import 'package:nwara_store_desktop/features/profit_sharing/viewmodel/get_profit_share_cubit.dart';

import 'delete_share_profit_dialog.dart';

class ProfitSharingWrapItem extends StatelessWidget {
  const ProfitSharingWrapItem({super.key,required this.title,required this.amount,required this.itemKey,required this.getProfitShareCubit});
final String title;
final double amount;
final dynamic itemKey;
final GetProfitShareCubit getProfitShareCubit;
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xFF293038))
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return DeleteShareProfitDialog(
                name: title,
                itemKey: itemKey,
              );
            },
        ).then((value) {
          getProfitShareCubit.getAllProfitShares();
        },);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title,style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),),

            Text(amount.toString(),style: TextStyle(
              fontSize: 16,
            ),),
          ],
        ),
      ),
    );
  }
}
