import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(constructor: '_')
class Category extends Equatable {
  const Category._({required this.name, this.id});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  final int? id;
  final String name;

  @override
  List<Object?> get props => [id, name];

  Category copyWith({
    int? id,
    String? name,
  }) {
    return Category._(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
