import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:nwara_store_desktop/core/features/inventory/view/pages/inventory_tab.dart';
import 'package:nwara_store_desktop/core/features/home/view/pages/invoice_tab.dart';

part 'rail_bar_state.dart';

class RailBarCubit extends Cubit<RailBarState> {
  RailBarCubit() : super(RailBarInitial());
  int currentTapIndex = 0;
  List<Widget> tabs = [
    const InvoiceTab(),
    const InventoryTab(),
  ];
  void changeIndex(int index) {
    currentTapIndex = index;
    emit(ChangeRailBarState());
  }
}
