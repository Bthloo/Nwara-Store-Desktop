import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../core/database/hive/profit_sharing_model.dart';

part 'delete_share_profit_state.dart';

class DeleteShareProfitCubit extends Cubit<DeleteShareProfitState> {
  DeleteShareProfitCubit() : super(DeleteShareProfitInitial());
  final box = Hive.box<ProfitSharingModel>('profit_sharing');
  void deleteProfitShare(int key) async {
    try {
      emit(DeleteShareProfitLoading());
      await box.delete(key);
      emit(DeleteShareProfitSuccess());
    } catch (e) {
      emit(DeleteShareProfitFailure(e.toString()));
    }
  }
}
