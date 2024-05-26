import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
// ignore: implementation_imports
import 'package:zod_validation/src/models/validade_model.dart';
import 'package:zod_validation/zod_validation.dart';

part 'new_category_request.g.dart';

@JsonSerializable()
class NewCategoryRequest extends Equatable {
  const NewCategoryRequest({required this.name});

  factory NewCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$NewCategoryRequestFromJson(json);

  final String name;

  ValidateModel validate(Map<String, dynamic> data) {
    return Zod.validate(
      data: data,
      params: {'name': Zod().required()},
    );
  }

  Map<String, dynamic> toJson() => _$NewCategoryRequestToJson(this);

  @override
  List<Object> get props => [name];
}
