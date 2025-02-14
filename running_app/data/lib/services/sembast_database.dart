import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';

class SembastDatabase {
  static const String _dbName = 'pending_alerts.db';
  static const String _storeName = 'alerts';

  static final SembastDatabase instance = SembastDatabase._private();
  SembastDatabase._private();

  Database? _database;
  final _store = StoreRef<String, Map<String, dynamic>>(_storeName);

  Future<Database> get database async {
    if (_database == null) {
      final dir = await getApplicationDocumentsDirectory();
      final dbPath = join(dir.path, _dbName);
      _database = await databaseFactoryIo.openDatabase(dbPath);
    }
    return _database!;
  }

  Future<Database> close() async {
    if (_database != null) {
      await _database!.close();
    }
    return _database!;
  }

  Future<void> insertAlert(String id, Map<String, dynamic> alert) async {
    final db = await database;
    await _store.record(id).put(db, alert);
  }

  Future<List<RecordSnapshot<String, Map<String, dynamic>>>> getAllAlerts() async {
    final db = await database;
    return await _store.find(db);
  }

  Future<void> deleteAlert(String id) async {
    final db = await database;
    await _store.record(id).delete(db);
  }
}
