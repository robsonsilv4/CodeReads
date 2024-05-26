import 'dart:async';
import 'dart:io';

import 'package:backend/categories/categories.dart';
import 'package:backend/validators/validators.dart';
import 'package:dart_frog/dart_frog.dart';

FutureOr<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Future<Response> _onPost(RequestContext context) async {
  final data = await context.request.json();
  if (data is! Map<String, dynamic>) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'message': 'Invalid request body.'},
    );
  }
  final category = NewCategoryRequest.fromJson(data);
  final validation = category.validate(data);
  if (validation.isNotValid) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: validation.result,
    );
  }
  final repository = context.read<CategoryRepository>();
  final existingValidator = context.read<ExistingValidator>();
  final existingCategory = await existingValidator.validate(
    storeName: repository.storeName,
    fieldName: 'name',
    value: category.name,
  );
  if (existingCategory != null) {
    return existingCategory.toResponse();
  }
  await repository.save(category.toJson());
  return Response.json(
    statusCode: HttpStatus.created,
    body: category.toJson(),
  );
}
