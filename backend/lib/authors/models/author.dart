import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'author.g.dart';

@JsonSerializable()
class Author extends Equatable {
  const Author({
    required this.email,
    required this.name,
    required this.description,
    this.id,
    this.createdAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  final int? id;
  final String email;
  final String name;
  final String description;
  final DateTime? createdAt;

  Author copyWith({
    int? id,
    String? email,
    String? name,
    String? description,
    DateTime? createdAt,
  }) {
    return Author(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        description,
        createdAt,
      ];
}
