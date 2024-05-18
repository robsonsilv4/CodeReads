import 'package:backend/authors/models/author.dart';
import 'package:sembast/sembast.dart';

class AuthorRepository {
  const AuthorRepository({required Database database}) : _database = database;

  final Database _database;

  static const _storeName = '_authors';

  Future<Author> save(Author author) async {
    final store = intMapStoreFactory.store(_storeName);
    final authorCopy = author.copyWith(createdAt: DateTime.now());
    final key = await store.add(_database, authorCopy.toJson());
    return authorCopy.copyWith(id: key);
  }
}
