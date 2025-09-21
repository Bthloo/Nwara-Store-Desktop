import 'package:hive/hive.dart';
part 'profit_sharing_model.g.dart';
@HiveType(typeId: 2)
class ProfitSharingModel extends HiveObject{
  @HiveField(0)
  String name;
  @HiveField(1)
  double amount;
  ProfitSharingModel({required this.name, required this.amount});
}