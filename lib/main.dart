import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nwara_store_desktop/core/components/theme_data.dart';
import 'package:nwara_store_desktop/core/database/hive/invoice_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nwara_store_desktop/core/database/hive/profit_sharing_model.dart';
import 'core/database/hive/inventory_model.dart';
import 'features/home/view/pages/home_screen.dart';
import 'features/invoice_item/view/pages/invoice_item.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(InventoryModelAdapter());
 Hive.registerAdapter(InvoiceModelAdapter());
  Hive.registerAdapter(ProfitSharingModelAdapter());
  await Hive.openBox<InventoryModel>('inventory');
  await Hive.openBox<InvoiceModel>('invoices');
  await Hive.openBox<ProfitSharingModel>('profit_sharing');

  // Directory dir = await getApplicationSupportDirectory();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: Locale('ar'),
      supportedLocales: [
        Locale('ar', ''),
      ],

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
     initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        InvoiceItem.routeName: (context) => const InvoiceItem(),
      },

    );
  }
}
