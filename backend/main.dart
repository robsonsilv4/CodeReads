import 'dart:io';

import 'package:backend/helpers/directory_helper.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:path/path.dart' as path;
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

late final Database _database;

Future<void> init(InternetAddress ip, int port) async {
  final currentDirectory = Directory.current.path;
  final projectRoot = findProjectRoot(currentDirectory);
  final databasePath = path.join(projectRoot, 'database.db');
  _database = await databaseFactoryIo.openDatabase(databasePath);
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) {
  return serve(
    handler.use(provider<Database>((context) => _database)),
    ip,
    port,
  );
}
