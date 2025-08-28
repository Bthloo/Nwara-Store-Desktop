
import 'package:hive/hive.dart';

part 'inventory_model.g.dart';

@HiveType(typeId: 0)
class InventoryModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double purchasedPrice;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  double sellPrice;

  InventoryModel({
    required this.id,
    required this.title,
    required this.purchasedPrice,
    required this.quantity,
    required this.sellPrice,
  });
}