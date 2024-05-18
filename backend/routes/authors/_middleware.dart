import 'package:backend/authors/authors.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:sembast/sembast.dart';

Handler middleware(Handler handler) {
  return handler.use(
    provider<AuthorRepository>(
      (context) => AuthorRepository(database: context.read<Database>()),
    ),
  );
}
