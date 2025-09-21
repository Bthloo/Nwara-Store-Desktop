import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:nwara_store_desktop/features/dashboard/view/pages/dash_board_tab.dart';
import 'package:nwara_store_desktop/features/settings/view/pages/settings_tab.dart';
import '../../inventory/view/pages/inventory_tab.dart';
import '../../invoice/view/pages/invoice_tab.dart';
import '../../profit_sharing/view/pages/profit_sharing_screen.dart';

part 'rail_bar_state.dart';

class RailBarCubit extends Cubit<RailBarState> {
  RailBarCubit() : super(RailBarInitial());
  int currentTapIndex = 0;
  List<Widget> tabs = [
    const InvoiceTab(),
    const InventoryTab(),
    const ProfitSharingScreen(),
    const DashBoardPage(),
    const SettingsTab(),

  ];
  void changeIndex(int index) {
    currentTapIndex = index;
    emit(ChangeRailBarState());
  }
}
