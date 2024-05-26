import 'package:backend/categories/categories.dart';
import 'package:sembast/sembast.dart';

class CategoryRepository {
  CategoryRepository({required Database database}) : _database = database;

  final Database _database;

  static const _storeName = '_categories';

  Future<int> save(Map<String, dynamic> data) async {
    final store = intMapStoreFactory.store(_storeName);
    return store.add(_database, data);
  }

  Future<Category?> findByName(String name) async {
    final store = intMapStoreFactory.store(_storeName);
    final query = Finder(filter: Filter.equals('name', name));
    final record = await store.findFirst(_database, finder: query);
    return record == null ? null : Category.fromJson(record.value);
  }
}
