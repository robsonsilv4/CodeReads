import 'dart:io';

import 'package:backend/database/database.dart';
import 'package:dart_frog/dart_frog.dart';

typedef ValidationResult = Map<String, String>;

class ExistingValidator {
  ExistingValidator({required Database database}) : _database = database;

  final Database _database;

  Future<ValidationResult?> validate({
    required String storeName,
    required String fieldName,
    required Object value,
  }) async {
    final existingRecord = await _database.findBy(
      storeName: storeName,
      fieldName: fieldName,
      value: value,
    );
    return existingRecord != null
        ? {fieldName: '$value already exists.'}
        : null;
  }
}

extension ExistingValidatorResponse on ValidationResult {
  Response toResponse() {
    return Response.json(
      statusCode: HttpStatus.conflict,
      body: this,
    );
  }
}
