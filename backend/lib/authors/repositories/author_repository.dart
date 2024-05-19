import 'package:backend/authors/authors.dart';
import 'package:sembast/sembast.dart';

class AuthorRepository {
  const AuthorRepository({required Database database}) : _database = database;

  final Database _database;

  static const _storeName = '_authors';

  Future<int> save(Author author) async {
    final store = intMapStoreFactory.store(_storeName);
    final newAuthor = author.copyWith(createdAt: DateTime.now());
    return store.add(_database, newAuthor.toJson());
  }
}
