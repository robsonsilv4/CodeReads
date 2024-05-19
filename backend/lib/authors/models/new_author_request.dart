import 'package:backend/authors/authors.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_author_request.g.dart';

@JsonSerializable()
class NewAuthorRequest extends Equatable {
  const NewAuthorRequest({
    required this.email,
    required this.name,
    required this.description,
  });

  factory NewAuthorRequest.fromJson(Map<String, dynamic> json) =>
      _$NewAuthorRequestFromJson(json);

  final String email;
  final String name;
  final String description;

  Author toModel() => Author(
        email: email,
        name: name,
        description: description,
      );

  Map<String, dynamic> toJson() => _$NewAuthorRequestToJson(this);

  @override
  List<Object?> get props => [email, name, description];
}
