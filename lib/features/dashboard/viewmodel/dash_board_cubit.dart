import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../core/database/hive/inventory_model.dart';
import '../../../core/database/hive/invoice_model.dart';
import '../../../core/database/hive/profit_sharing_model.dart';

part 'dash_board_state.dart';

class DashBoardCubit extends Cubit<DashBoardState> {
  DashBoardCubit() : super(DashBoardInitial());

  final inventoryBox = Hive.box<InventoryModel>('inventory');
  final invoiceBox = Hive.box<InvoiceModel>('invoices');
  final profitBox = Hive.box<ProfitSharingModel>('profit_sharing');

  Future<void> loadDashboard() async {
    try {
      emit(DashboardLoading());

      // إجمالي العناصر
      final totalItems = inventoryBox.values.fold<int>(
        0,
            (sum, item) => sum + item.quantity,
      );

      // إجمالي قيمة المخزون
      final totalInventoryValue = inventoryBox.values.fold<double>(
        0.0,
            (sum, item) => sum + (item.purchasedPrice * item.quantity),
      );

      // إجمالي المبيعات
      final totalSales = invoiceBox.values.fold<double>(
        0.0,
            (sum, invoice) => sum +
            invoice.items.fold<double>(
              0.0,
                  (sub, item) => sub + (item.sellPrice * item.quantity),
            ),
      );

      // إجمالي الأرباح
      final totalProfit = totalSales - totalInventoryValue;

      // عدد الفواتير
      final totalInvoices = invoiceBox.length;

      // مجموع العناصر المباعة
      final totalSoldItems = invoiceBox.values.fold<int>(
        0,
            (sum, invoice) =>
        sum + invoice.items.fold<int>(0, (s, item) => s + item.quantity),
      );

      // المنتجات منخفضة المخزون (مثلاً أقل من 5)
      final lowStockItemsList = inventoryBox.values
          .where((item) => item.quantity < 5)
          .toList();

      // آخر 5 فواتير
      final recentInvoices = invoiceBox.values.toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      final lastInvoices = recentInvoices.take(5).toList();

      // بيانات توزيع الأرباح
      final profitSharing = profitBox.values.toList();

      emit(DashBoardSuccess(
        totalItems: totalItems,
        totalInventoryValue: totalInventoryValue,
        totalSales: totalSales,
        totalProfit: totalProfit,
        totalInvoices: totalInvoices,
        totalSoldItems: totalSoldItems,
        lowStockItemsList: lowStockItemsList,
        recentInvoices: lastInvoices,
        profitSharing: profitSharing,
      ));
    } catch (e) {
      emit(DashBoardFailure(e.toString()));
    }
  }
}
