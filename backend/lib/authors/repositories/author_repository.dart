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

  Future<Author?> findByEmail(String email) async {
    final store = intMapStoreFactory.store(_storeName);
    final query = Finder(filter: Filter.equals('email', email));
    final record = await store.findFirst(_database, finder: query);
    return record == null ? null : Author.fromJson(record.value);
  }
}
