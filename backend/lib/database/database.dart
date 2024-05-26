import 'package:sembast/sembast.dart' as sembast;

typedef RecordValue = Map<String, dynamic>;

class Database {
  const Database({required sembast.Database database}) : _database = database;

  final sembast.Database _database;

  /// Saves a record to the database.
  /// Returns the id of the record.
  Future<int> save(String storeName, RecordValue value) async {
    final store = sembast.intMapStoreFactory.store(storeName);
    return store.add(_database, value);
  }

  /// Finds a record by a field value.
  /// Returns the record value or null if not found.
  Future<RecordValue?> findBy({
    required String storeName,
    required String fieldName,
    required Object value,
  }) async {
    final store = sembast.intMapStoreFactory.store(storeName);
    final query =
        sembast.Finder(filter: sembast.Filter.equals(fieldName, value));
    final record = await store.findFirst(_database, finder: query);
    return record?.value;
  }
}
