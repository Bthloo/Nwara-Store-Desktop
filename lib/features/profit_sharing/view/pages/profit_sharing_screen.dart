import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/color_helper.dart';
import 'package:nwara_store_desktop/core/components/custom_form_field.dart';
import 'package:nwara_store_desktop/features/profit_sharing/viewmodel/get_profit_share_cubit.dart';
import 'package:nwara_store_desktop/features/profit_sharing/viewmodel/share_profit_cubit.dart';

import '../components/add_profit_share_dialog.dart';
import '../components/profit_sharing_wrap_item.dart';

class ProfitSharingScreen extends StatelessWidget {
  const ProfitSharingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      GetProfitShareCubit()
        ..getAllProfitShares(),
      child: BlocBuilder<GetProfitShareCubit, GetProfitShareState>(

  builder: (context, state) {
    if(state is GetProfitShareLoading){
      return const Center(child: CircularProgressIndicator());
    } else if(state is GetProfitShareFailure){
      return Center(child: Text(state.error, style: const TextStyle(color: Colors.red),),);
    }else if(state is GetProfitShareSuccess){
      return Scaffold(
        appBar: AppBar(title: const Text("تقسيم الارباح"), centerTitle: false),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          onPressed:() {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return AddProfitShareDialog(remainingProfit: context.read<GetProfitShareCubit>().availableProfit,);
              },
            ).then((value) {
              if(context.mounted){
                context.read<GetProfitShareCubit>().totalProfit = 0;
                context.read<GetProfitShareCubit>().availableProfit = 0;
                context.read<GetProfitShareCubit>().remainingProfit = 0;
                context.read<GetProfitShareCubit>().getAllProfitShares();
              }
            },);
          },
          icon: Icon(Icons.money_sharp,color: Colors.white,),
          label: Text("تقسيم الارباح",style: TextStyle(
              color: Colors.white
          ),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF293038),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("اجمالي الارباح : ${context.read<GetProfitShareCubit>().totalProfit}", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text("المتبقي : ${context.read<GetProfitShareCubit>().availableProfit}", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              state.profitShares.isEmpty ? const Center(child: Text("لم تقم بالتقسيم بعد"),) :
              Wrap(
                spacing: 10,
                children: state.profitShares.map((e) => ProfitSharingWrapItem(
                  getProfitShareCubit: context.read<GetProfitShareCubit>(),
                    itemKey: e.key,
                    title: e.name, amount: e.amount)).toList(),

          )
            ],
          ),
        ),
      )
      );
    }else{
      return const Center(child: Text("حدث خطأ غير معروف"),);
    }

  },
),
    );
  }
}
