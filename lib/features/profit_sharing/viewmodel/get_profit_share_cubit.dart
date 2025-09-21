import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../core/database/hive/invoice_model.dart';
import '../../../core/database/hive/profit_sharing_model.dart';

part 'get_profit_share_state.dart';

class GetProfitShareCubit extends Cubit<GetProfitShareState> {
  GetProfitShareCubit() : super(GetProfitShareInitial());
  final box = Hive.box<ProfitSharingModel>('profit_sharing');
  final invoiceBox = Hive.box<InvoiceModel>('invoices');
  double totalProfit = 0.0;
  double remainingProfit = 0.0;
  double availableProfit = 0.0;
  getAllProfitShares() async {
    try {
       totalProfit = 0.0;
       remainingProfit = 0.0;
       availableProfit = 0.0;
      emit(GetProfitShareLoading());
     final invoices = invoiceBox.values.toList();
     for(var invoice in invoices){
      for (var element in invoice.items) {
       double profit =  element.sellPrice - element.purchasedPrice;
          totalProfit += profit * element.quantity;
        }
       }
      final profitShares = box.values.toList();
     for (var element in profitShares) {
      remainingProfit += element.amount;
     }
     availableProfit = totalProfit - remainingProfit;
      emit(GetProfitShareSuccess(profitShares));
    } catch (e) {
      emit(GetProfitShareFailure(e.toString()));
    }
  }
}
