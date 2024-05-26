import 'dart:async';
import 'dart:io';

import 'package:backend/authors/authors.dart';
import 'package:backend/validators/validators.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:zod_validation/zod_validation.dart';

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
  final validation = Zod.validate(
    data: data,
    params: {
      'email': Zod().email().required(),
      'name': Zod().required(),
      'description': Zod().max(400).required(),
    },
  );
  if (validation.isNotValid) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: validation.result,
    );
  }
  final author = NewAuthorRequest.fromJson(data);
  final repository = context.read<AuthorRepository>();
  final existingValidator = context.read<ExistingValidator>();
  final existingAuthor = await existingValidator.validate(
    storeName: repository.storeName,
    fieldName: 'email',
    value: author.email,
  );
  if (existingAuthor != null) {
    return existingAuthor.toResponse();
  }
  await repository.save(author.toModel());
  return Response.json(
    statusCode: HttpStatus.created,
    body: author.toJson(),
  );
}
