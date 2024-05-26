import 'package:backend/categories/categories.dart';
import 'package:backend/database/database.dart';

class CategoryRepository {
  CategoryRepository({required Database database}) : _database = database;

  final Database _database;

  static const _storeName = '_categories';

  Future<int> save(Map<String, dynamic> data) async {
    return _database.save(_storeName, data);
  }

  Future<Category?> findByName(String name) async {
    final data = await _database.findBy(
      storeName: _storeName,
      fieldName: 'name',
      value: name,
    );
    return data == null ? null : Category.fromJson(data);
  }
}
