part of 'dash_board_cubit.dart';

@immutable
sealed class DashBoardState {}

final class DashBoardInitial extends DashBoardState {}
final class DashboardLoading extends DashBoardState {}

final class DashBoardSuccess extends DashBoardState {
  final int totalItems;
  final double totalInventoryValue;
  final double totalSales;
  final double totalProfit;
  final int totalInvoices;
  final int totalSoldItems;
  final List<InventoryModel> lowStockItemsList;
  final List<InvoiceModel> recentInvoices;
  final List<ProfitSharingModel> profitSharing;

  DashBoardSuccess({
    required this.totalItems,
    required this.totalInventoryValue,
    required this.totalSales,
    required this.totalProfit,
    required this.totalInvoices,
    required this.totalSoldItems,
    required this.lowStockItemsList,
    required this.recentInvoices,
    required this.profitSharing,
  });
}

final class DashBoardFailure extends DashBoardState {
  final String error;
  DashBoardFailure(this.error);
}
