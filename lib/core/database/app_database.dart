import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'models/inventory_model.dart';


part 'app_database.g.dart';


@DriftDatabase(tables: [InventoryItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) {
      return m.createAll();
    },
    onUpgrade: (m, from, to) async {

    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final file = await _getDatabaseFile();
    return NativeDatabase.createInBackground(file);
  });
}

Future<File> _getDatabaseFile() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, 'app_database.sqlite'));
  } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    final dir = Directory.current;
    return File(p.join(dir.path, 'app_database.sqlite'));
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}
