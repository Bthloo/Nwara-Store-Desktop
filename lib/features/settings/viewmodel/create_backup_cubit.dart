import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../core/database/hive/inventory_model.dart';
import '../../../core/database/hive/invoice_model.dart';
import '../../../core/database/hive/profit_sharing_model.dart';

part 'create_backup_state.dart';

class CreateBackupCubit extends Cubit<CreateBackupState> {
  CreateBackupCubit() : super(CreateBackupInitial());
  void createBackup() async {
    try {
      emit(CreateBackupLoading());

     final file = await exportAllToJson();
      emit(CreateBackupSuccess(file: file));
    } catch (e) {
      emit(CreateBackupFailure(e.toString()));
    }
  }

  Future<File> exportAllToJson() async {
    final inventoryBox = Hive.box<InventoryModel>('inventory');
    final invoiceBox = Hive.box<InvoiceModel>('invoices');
    final profitBox = Hive.box<ProfitSharingModel>('profit_sharing');

    final data = {
      "inventory": inventoryBox.values.map((e) => {
        "id": e.id,
        "title": e.title,
        "purchasedPrice": e.purchasedPrice,
        "quantity": e.quantity,
        "sellPrice": e.sellPrice,
      }).toList(),
      "invoices": invoiceBox.values.map((e) => {
        "id": e.id,
        "title": e.title,
        "date": e.date.toIso8601String(),
        "items": e.items.map((item) => {
          "id": item.id,
          "title": item.title,
          "purchasedPrice": item.purchasedPrice,
          "quantity": item.quantity,
          "sellPrice": item.sellPrice,
        }).toList(),
      }).toList(),
      "profit_sharing": profitBox.values.map((e) => {
        "name": e.name,
        "amount": e.amount,
      }).toList(),
    };

    final jsonString = const JsonEncoder.withIndent("  ").convert(data);

    final timestamp = DateTime.now().toIso8601String().replaceAll(":", "-");
    final file = File("nwara_store_backup_$timestamp.json");

    await file.writeAsString(jsonString);
    debugPrint("Backup created at: ${file.absolute.parent}");
    return file;
  }

}
