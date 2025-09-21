import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../core/database/hive/profit_sharing_model.dart';

part 'share_profit_state.dart';

class ShareProfitCubit extends Cubit<ShareProfitState> {
  ShareProfitCubit() : super(ShareProfitInitial());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final box = Hive.box<ProfitSharingModel>('profit_sharing');
  void shareProfit() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      emit(ShareProfitLoading());
      double amount = double.parse(amountController.text);
      final profitShare = ProfitSharingModel(
       name: nameController.text,
        amount: amount
      );
      await box.add(profitShare);
      emit(ShareProfitSuccess());
    } catch (e) {
      emit(ShareProfitFailure(e.toString()));
    }
  }
  @override
  Future<void> close() {
    nameController.dispose();
    amountController.dispose();
    return super.close();
  }
}
