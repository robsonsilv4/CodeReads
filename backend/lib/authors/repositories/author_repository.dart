import 'package:backend/authors/authors.dart';
import 'package:backend/database/database.dart';

class AuthorRepository {
  const AuthorRepository({required Database database}) : _database = database;

  final Database _database;

  static const _storeName = '_authors';

  Future<int> save(Author author) async {
    return _database.save(_storeName, author.toJson());
  }

  Future<Author?> findByEmail(String email) async {
    final data = await _database.findBy(
      storeName: _storeName,
      fieldName: 'email',
      value: email,
    );
    return data == null ? null : Author.fromJson(data);
  }
}
