import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nwara_store_desktop/core/components/color_helper.dart';
import 'package:nwara_store_desktop/core/features/home/viewmodel/rail_bar_cubit.dart';
import 'package:sidebarx/sidebarx.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RailBarCubit(),
      child: BlocBuilder<RailBarCubit, RailBarState>(
        builder: (context, state) {
          final cubit = context.read<RailBarCubit>();

          return Scaffold(

            body: Row(
              children: [
                // NavigationRail(
                //   backgroundColor: ColorHelper.darkColor,
                //   extended: true,
                //   useIndicator: false,
                //   indicatorColor: Colors.grey,
                //   unselectedIconTheme: IconThemeData(
                //     color: Colors.grey
                //   ),
                //   selectedIconTheme: IconThemeData(
                //     color: Colors.white
                //   ),
                //   selectedLabelTextStyle: TextStyle(
                //     color: Colors.white
                //   ),
                //   unselectedLabelTextStyle: TextStyle(
                //     color: Colors.grey
                //   ),
                //   labelType: NavigationRailLabelType.none,
                //   selectedIndex: cubit.currentTapIndex,
                //   onDestinationSelected: (index) {
                //     cubit.changeIndex(index);
                //   },
                //   destinations: [
                //     NavigationRailDestination(
                //       icon: _buildRailItem(
                //         icon: Icons.receipt_long,
                //         label: 'Invoices',
                //
                //       ),
                //       label: const SizedBox.shrink(),
                //     ),
                //     NavigationRailDestination(
                //       icon: _buildRailItem(
                //         icon: Icons.inventory,
                //         label: 'Inventory',
                //
                //       ),
                //       label: const SizedBox.shrink(),
                //     ),
                //   ],
                // ),

                SidebarX(
                  showToggleButton: false,headerBuilder: (context, extended) {
                    return Text("Nwara Store",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                    );
                  },
                    theme: SidebarXTheme(
                      decoration: BoxDecoration(
                        color: ColorHelper.darkColor
                      ),
                      width: MediaQuery.sizeOf(context).width * 0.150,
                     selectedItemTextPadding: const EdgeInsets.all(5),
                      itemTextPadding: const EdgeInsets.all(5),
                      hoverColor: Color(0xC8293038),
                      hoverTextStyle: TextStyle(
                          color: Colors.white
                      ),
                      hoverIconTheme: IconThemeData(
                          color: Colors.white
                      ),
                      padding: const EdgeInsets.all(5),
                      textStyle: TextStyle(
                          color: Colors.grey
                      ),
                      iconTheme: IconThemeData(
                          color: Colors.grey
                      ),
                      selectedTextStyle: TextStyle(
                        color: Colors.white
                      ),
                      selectedIconTheme: IconThemeData(
                          color: Colors.white
                      ),
                      selectedItemDecoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        color: Color(0xFF293038)
                      )
                    ),
                    controller: SidebarXController(
                      selectedIndex: cubit.currentTapIndex,
                      extended: true,
                    ),
                  items: [
                    SidebarXItem(
                      icon: Icons.receipt_long,
                      label: 'الفواتير',
                      onTap: () => cubit.changeIndex(0),
                    ),
                    SidebarXItem(
                      icon: Icons.inventory,
                      label: 'المخزن',
                      onTap: () => cubit.changeIndex(1),
                    ),
                  ],

                ),
                Expanded(
                  child: cubit.tabs[cubit.currentTapIndex],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


Widget _buildRailItem({
  required IconData icon,
  required String label,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon,),
        const SizedBox(width: 10),
        Text(
          label,
        ),
      ],
    ),
  );
}