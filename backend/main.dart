import 'dart:io';

import 'package:backend/database/database.dart';
import 'package:backend/helpers/directory_helper.dart';
import 'package:backend/validators/validators.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:path/path.dart' as path;
import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast/sembast_io.dart' show databaseFactoryIo;
import 'package:zod_validation/src/locales/locale_en.dart';
import 'package:zod_validation/zod_validation.dart';

late final sembast.Database _database;

Future<void> init(InternetAddress ip, int port) async {
  // Database setup
  final currentDirectory = Directory.current.path;
  final projectRoot = findProjectRoot(currentDirectory);
  final databasePath = path.join(projectRoot, 'database.db');
  _database = await databaseFactoryIo.openDatabase(databasePath);
  // Localization setup
  Zod.zodLocaleInstance = LocaleEN();
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(
    handler.use(provider<Database>((_) => Database(database: _database))).use(
          provider(
            (_) => ExistingValidator(database: Database(database: _database)),
          ),
        ),
    ip,
    port,
  );
}
