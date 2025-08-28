import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/color_helper.dart';
import '../../viewmodel/get_inventory_items_cubit.dart';
import '../components/add_item_dialog.dart';
import '../components/inventory_table.dart';

class InventoryTab extends StatelessWidget {
  const InventoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => GetInventoryItemsCubit()..getAllInventoryItems(),
  child: Builder(
    builder: (context) {
      final getCubit = context.read<GetInventoryItemsCubit>();
      return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                title: const Text("المخزن"),
                centerTitle: false,
              bottom: TabBar(
                  isScrollable: true ,
                padding: EdgeInsets.symmetric(horizontal: 10),
                indicator: BoxDecoration(
                  color:  const Color(0xFF293038),
                  borderRadius: BorderRadius.circular(10),
                ),
                dividerColor: Colors.transparent,
                indicatorSize:TabBarIndicatorSize.tab ,
                unselectedLabelStyle: const TextStyle(
                  color: ColorHelper.secondaryColor,
                  fontFamily: "Cairo",
                ),
                labelStyle: const TextStyle(
                    color: Colors.white,
                  fontFamily: "Cairo",
                ),
                tabs: const [
                  Tab(text: "الكل"),
                  Tab(text: "المتوفر"),
                  Tab(text: "الفارغ"),
                ],
            ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: ColorHelper.darkColor,
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (dialogContext) {
                          return AddInventoryItemDialog(getCubit: getCubit);
                        },
                      );
                    },
                    child: const Text("اضافة منتج جديد"),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BlocBuilder<GetInventoryItemsCubit, GetInventoryItemsState>(
                builder: (context, getInventoryItemsState) {
                  if (getInventoryItemsState is GetInventoryItemsLoading) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (getInventoryItemsState is GetInventoryItemsFailure) {
                    return Center(
                      child: Text(
                        getInventoryItemsState.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (getInventoryItemsState is GetInventoryItemsSuccess) {
                    final items = getInventoryItemsState.items;
                      return Column(
                        children: [
                          SizedBox(height: 10,),
                          TextField(
                            onChanged: (value) {
                              context.read<GetInventoryItemsCubit>().filterItems(value);
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF293038),
                              prefixIcon: const Icon(Icons.search, color: Color(0xFF9CABBA)),
                              hintText: "ابحث عن منتج",
                              hintStyle: const TextStyle(color: Color(0xFF9CABBA)),
                              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.blue, width: 1),
                              ),
                            ),
                          ),
        
                          const SizedBox(height: 20),
                          items.isEmpty ? const Center(child: Text("لم يتم العثور على منتجات")) :
                          Expanded(
                            child: TabBarView(
                              children: [
                                items.isEmpty
                                    ? const Center(child: Text("لم يتم العثور على منتجات"))
                                    : InventoryTable(items: items, getCubit: getCubit),
                                items.where((e) => e.quantity > 0).isEmpty
                                    ? const Center(child: Text("لا يوجد منتجات متوفرة"))
                                    : InventoryTable(
                                  items: items.where((e) => e.quantity > 0).toList(),
                                  getCubit: getCubit,
                                ),
                                items.where((e) => e.quantity == 0).isEmpty
                                    ? const Center(child: Text("لا يوجد منتجات فاضية"))
                                    : InventoryTable(
                                  items: items.where((e) => e.quantity == 0).toList(),
                                  getCubit: getCubit,
                                ),


                              ],
                            ),
                          ),
        
        
        
                        ],
                      );
                  } else {
                    return Center(
                      child: Text(
                        "حدث خطأ غير معروف",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
      );
    }
  ),
);
  }
}
