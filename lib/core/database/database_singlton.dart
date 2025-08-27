import 'app_database.dart';

class AppDatabaseSingleton {
  AppDatabaseSingleton._internal();

  static final AppDatabaseSingleton _instance = AppDatabaseSingleton._internal();
  factory AppDatabaseSingleton() => _instance;

  static AppDatabase? _db;

  AppDatabase get db {
    _db ??= AppDatabase();
    return _db!;
  }
}
