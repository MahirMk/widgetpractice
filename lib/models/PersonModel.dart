import 'package:json_annotation/json_annotation.dart';

part 'PersonModel.g.dart';

@JsonSerializable()
class Person {
  Person({this.name, this.id});
  int? id;
  String? name;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}


