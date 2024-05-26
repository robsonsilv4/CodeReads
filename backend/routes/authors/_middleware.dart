import 'package:backend/authors/authors.dart';
import 'package:backend/database/database.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(
    provider<AuthorRepository>(
      (context) => AuthorRepository(database: context.read<Database>()),
    ),
  );
}
