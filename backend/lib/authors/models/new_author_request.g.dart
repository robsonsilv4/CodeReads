// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_author_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewAuthorRequest _$NewAuthorRequestFromJson(Map<String, dynamic> json) =>
    NewAuthorRequest(
      email: json['email'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$NewAuthorRequestToJson(NewAuthorRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'description': instance.description,
    };
