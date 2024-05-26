import 'package:backend/categories/categories.dart';
import 'package:backend/database/database.dart';
import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return handler.use(
    provider<CategoryRepository>(
      (context) => CategoryRepository(database: context.read<Database>()),
    ),
  );
}
