// import 'package:drift/drift.dart';
//
// class Invoices extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get name => text()();
//   DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
// }
//
// class InvoiceItems extends Table {
//   IntColumn get id => integer().autoIncrement()();
//
//   IntColumn get invoiceId =>
//       integer().customConstraint('REFERENCES invoices(id) ON DELETE CASCADE')();
//
//   IntColumn get itemId =>
//       integer().nullable().customConstraint('NULL REFERENCES inventory_items(id)')();
//
//   TextColumn get customTitle => text().nullable()();
//
//   RealColumn get purchasedPrice => real()();
//   RealColumn get sellPrice => real()();
//   IntColumn get quantity => integer()();
// }
