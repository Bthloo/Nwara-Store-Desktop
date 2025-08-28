import 'package:hive/hive.dart';

import 'inventory_model.dart';

part 'invoice_model.g.dart';

@HiveType(typeId: 1)
class InvoiceModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  List<InventoryModel> items;

  InvoiceModel({
    required this.id,
    required this.title,
    required this.date,
    required this.items,
  });
}
