import 'dart:async';
import 'dart:io';

import 'package:backend/authors/authors.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:zod_validation/zod_validation.dart';

FutureOr<Response> onRequest(RequestContext context) {
  return switch (context.request.method) {
    HttpMethod.post => _onPost(context),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Future<Response> _onPost(RequestContext context) async {
  final repository = context.read<AuthorRepository>();
  final data = await context.request.json() as Map<String, dynamic>;
  final validated = Zod.validate(
    data: data,
    params: {
      'email': Zod().email().required(),
      'name': Zod().required(),
      'description': Zod().max(400).required(),
    },
  );
  if (validated.isNotValid) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: validated.result,
    );
  }
  final author = NewAuthorRequest.fromJson(data);
  return Response.json(
    body: await repository.save(author.toModel()),
  );
}
