import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../database/app_database.dart';
import '../../../database/database_singlton.dart';

part 'get_inventory_items_state.dart';

class GetInventoryItemsCubit extends Cubit<GetInventoryItemsState> {
  GetInventoryItemsCubit() : super(GetInventoryItemsInitial());
  //static GetInventoryItemsCubit of(context) => BlocProvider.of<GetInventoryItemsCubit>(context);
  final db = AppDatabaseSingleton().db;

  getAllInventoryItems() async {
    try {
      emit(GetInventoryItemsLoading());
      final items = await db.select(db.inventoryItems).get();
      emit(GetInventoryItemsSuccess(items));
    } catch (e) {
      emit(GetInventoryItemsFailure(e.toString()));
    }
  }
}
