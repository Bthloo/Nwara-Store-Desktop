import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../viewmodel/dash_board_cubit.dart';


class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashBoardCubit()..loadDashboard(),
      child: Scaffold(
        appBar: AppBar(title: const Text('لوحة التحكم'),centerTitle: false,),
        body: BlocBuilder<DashBoardCubit, DashBoardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DashBoardFailure) {
              return Center(child: Text("حدث خطأ: ${state.error}"));
            } else if (state is DashBoardSuccess) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // KPIs
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3.5,
                      children: [
                        _buildKpiCard("إجمالي العناصر", "${state.totalItems}"),
                        _buildKpiCard("قيمة المخزون", state.totalInventoryValue.toStringAsFixed(2)),
                        _buildKpiCard("إجمالي المبيعات", state.totalSales.toStringAsFixed(2)),
                        _buildKpiCard("إجمالي الأرباح", state.totalProfit.toStringAsFixed(2)),
                        _buildKpiCard("عدد الفواتير", "${state.totalInvoices}"),
                        _buildKpiCard("العناصر المباعة", "${state.totalSoldItems}"),
                        _buildKpiCard("منتجات منخفضة المخزون أقل من 5", "${state.lowStockItemsList.length}"),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Bar Chart
                    _buildSectionTitle("المبيعات مقابل المخزون"),
                    SizedBox(height: 250, child: _buildBarChart(state)),

                    const SizedBox(height: 20),

                    // Pie Chart
                    _buildSectionTitle("توزيع الأرباح"),
                    SizedBox(height: 250, child: _buildPieChart(state)),

                    const SizedBox(height: 20),

                    // آخر الفواتير
                    _buildSectionTitle("آخر الفواتير"),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF293038),
                        borderRadius: BorderRadius.circular(12),
                      ),
                        height: 250, child: _buildRecentInvoices(state)),

                    const SizedBox(height: 20),

                    // عناصر منخفضة المخزون
                    _buildSectionTitle("منتجات منخفضة المخزون أقل من 5"),
                    Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF293038),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 250, child: _buildLowStockItems(state)),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value) {
    return Card(
      color: Color(0xFF293038),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            const Spacer(),
            Text(value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(title,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildBarChart(DashBoardSuccess state) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(toY: state.totalInventoryValue, color: Colors.blue),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(toY: state.totalSales, color: Colors.green),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                switch (value.toInt()) {
                  case 0:
                    return const Text("المخزون");
                  case 1:
                    return const Text("المبيعات");
                  default:
                    return const Text("");
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart(DashBoardSuccess state) {
    if (state.profitSharing.isEmpty) {
      return const Center(child: Text("لا توجد بيانات توزيع أرباح"));
    }
    return PieChart(
      PieChartData(
        sections: state.profitSharing.map((p) {
          final percentage =
          state.totalProfit == 0 ? 0 : (p.amount / state.totalProfit) * 100;
          return PieChartSectionData(
            title: "${p.name} ${(percentage).toStringAsFixed(1)}%",
            value: p.amount,
            color: Colors.primaries[state.profitSharing.indexOf(p) % Colors.primaries.length],
            radius: 80,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecentInvoices(DashBoardSuccess state) {
    return ListView.separated(
      separatorBuilder: (context, index) {
       return Divider();
      },
      itemCount: state.recentInvoices.length,
      itemBuilder: (context, index) {
        final invoice = state.recentInvoices[index];
        return ListTile(
          title: Text(invoice.title),
          subtitle: Text(
              "تاريخ: ${invoice.date.toLocal().toString().split(' ')[0]} | عناصر: ${invoice.items.length}"),
        );
      },
    );
  }

  Widget _buildLowStockItems(DashBoardSuccess state) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: state.lowStockItemsList.length,
      itemBuilder: (context, index) {
        final item = state.lowStockItemsList[index];
        return ListTile(
          title: Text(item.title),
          subtitle: Text("الكمية: ${item.quantity}"),
        );
      },
    );
  }
}
